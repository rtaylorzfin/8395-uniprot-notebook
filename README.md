Gather a subset of dblinks:

```
select * from db_link where dblink_fdbcont_zdb_id in (
'ZDB-FDBCONT-040412-36', --genbank
'ZDB-FDBCONT-040412-37', --genbank
'ZDB-FDBCONT-040412-47', --uniprot
'ZDB-FDBCONT-040412-42', --genpept
'ZDB-FDBCONT-040412-38', --refseq
'ZDB-FDBCONT-040412-39', --refseq
'ZDB-FDBCONT-110301-1', --ensembl_trans
'ZDB-FDBCONT-131021-1', --ensembl
'ZDB-FDBCONT-061018-1' --ensembl_grcz11
);
```


