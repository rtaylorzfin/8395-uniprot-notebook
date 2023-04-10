Reports for ZFIN-8395 (UniProt Load)
---

## Prerequisites

### Gathering Data

First, this report requires the raw data to work with.  Some are exported from our zfin database and some are downloads.
The prerequisites are partially compiled using the export.sh bash script.

The tables we export are: db_link, marker, feature_marker_relationship, external_note (some are limited to only certain entries by sql quere clauses).

The tables we download are: 
 uniprot2ensembl.csv (https://ftp.expasy.org/databases/uniprot/current_release/knowledgebase/idmapping/by_organism/DANRE_7955_idmapping.dat.gz)
 to_keep.csv (provided by dushy at https://ftp.ebi.ac.uk/pub/contrib/dushi/zfin/to_keep.dat)
 to_delete.csv (provided by dushy at https://ftp.ebi.ac.uk/pub/contrib/dushi/zfin/to_delete.dat)
 ncbi_map (https://ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Non-mammalian_vertebrates/Danio_rerio.gene_info.gz)
 refseq2ncbi.csv (created using gradle -DapiKey=3b0a6a579791d9b134b44c6559fbb4434708 -DncbiLoadInput=./to_keep_primary_ids.txt -DncbiLoadOutput=./refseq2ncbi batchNCBIFetchByRefSeqTask ) (see: zfin-8395 branch in rtaylorzfin)

In total, there should be the following tables to start out: db_link, refseq2ncbi, extnote_note, to_delete, feature_marker_relationship, to_keep, marker, uniprot2ensembl, ncbi_map.
All are included in the file zfin-db-slice.db.gz.
 
### Creating sqlite DB from Data

The above data files are imported into an sqlite database with csv-to-sqlite. The export.sh file shows some examples of doing that.

## Running Reports

### Running in the cloud:
These reports can be created dynamically using google's colaboratory at: https://colab.research.google.com/drive/1-ublRmMiadE1kX-3T9x4NkebqUqWw3LY#scrollTo=m4OQhvxYta5S

### Running locally:
This can also be run locally using jupyter.  Install prerequisites:

- pip3 install jupyterlab
- pip3 install notebook
- pip3 install pandas sqlalchemy ipython-sql
- pip3 install openpyxl
- pip3 install 'nbconvert[qtpdf]'

Then run "jupyter notebook" in this directory. Running locally has the advantage of better exports.  I have had success with exporting to html, then opening that html with MS Word and saving as docx.

