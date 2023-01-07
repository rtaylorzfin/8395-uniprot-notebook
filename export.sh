#!/bin/bash -e

# Requires this file: ncbi_map from https://ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Non-mammalian_vertebrates/Danio_rerio.gene_info.gz
# and uniprot2ensembl.csv from https://ftp.expasy.org/databases/uniprot/current_release/knowledgebase/idmapping/by_organism/DANRE_7955_idmapping.dat.gz
# maybe https://ftp.ncbi.nlm.nih.gov/refseq/D_rerio/Danio_rerio.gene_info.gz
# Also added refseq2ncbi.csv (created from querying ncbi api)

echo 'Exporting 6 tables to csv: db_link (limited), marker, to_keep, to_delete, uniprot2ensembl, extnote_note, feature_marker_relationship'
echo "\copy (select * from db_link where dblink_fdbcont_zdb_id in ( 'ZDB-FDBCONT-040412-36', 'ZDB-FDBCONT-040412-37', 'ZDB-FDBCONT-040412-47', 'ZDB-FDBCONT-040412-42', 'ZDB-FDBCONT-040412-38', 'ZDB-FDBCONT-040412-39', 'ZDB-FDBCONT-110301-1', 'ZDB-FDBCONT-131021-1', 'ZDB-FDBCONT-061018-1','ZDB-FDBCONT-200123-1')) to stdout with csv header"  | psql -h localhost zfindb > db_link.csv
echo "\copy (select * from uniprot2ensembl) to stdout with csv header"  | psql -h localhost zfindb > uniprot2ensembl.csv
echo "\copy (select * from marker) to stdout with csv header"  | psql -h localhost zfindb > marker.csv
echo "\copy (select * from to_keep) to stdout with csv header"  | psql -h localhost zfindb > to_keep.csv
echo "\copy (select * from to_delete) to stdout with csv header"  | psql -h localhost zfindb > to_delete.csv
echo "\copy (select * from feature_marker_relationship) to stdout with csv header"  | psql -h localhost zfindb > feature_marker_relationship.csv
echo "\copy (select * from external_note where extnote_note ilike '%ENSDARG%') to stdout with csv header"  | psql -h localhost zfindb > extnote_note.csv

echo 'Adding to sqlite db'
csv-to-sqlite -o zfin-db-slice.db -f db_link.csv
csv-to-sqlite -o zfin-db-slice.db -f uniprot2ensembl.csv
csv-to-sqlite -o zfin-db-slice.db -f marker.csv
csv-to-sqlite -o zfin-db-slice.db -f to_keep.csv
csv-to-sqlite -o zfin-db-slice.db -f to_delete.csv
csv-to-sqlite -o zfin-db-slice.db -f extnote_note.csv
csv-to-sqlite -o zfin-db-slice.db -f feature_marker_relationship.csv
csv-to-sqlite -D -x $'\t' -o zfin-db-slice.db -f ncbi_map
csv-to-sqlite -o zfin-db-slice.db -f refseq2ncbi

