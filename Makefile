#Run cellranger at different optons.
CR_testrun = cellranger testrun --id=tiny #To check if cellranger works.
TRANSCRIPTOME=/home/lucas_pkuhpc/lustre2/yuyangyang/refdata-gex-GRCh38-and-mm10-2020-A
LIBRARY = /home/lucas_pkuhpc/lustre2/yuyangyang/sci03_10k_v3/sci03_10k_protein_v3_library.csv
FEATURE_REFERENCE = /home/lucas_pkuhpc/lustre2/yuyangyang/sci03_10k_v3/sci03_10k_protein_v3_feature_ref.csv
CR_CMD = cellranger count \
	--libraries=$(LIBRARY) \
	--transcriptome=$(TRANSCRIPTOME) \
	--feature-ref=$(FEATURE_REFERENCE) \
	--localcores=8 \
	--localmem=128
CellRanger:
	pkurun-fat4way 1 8 $(CR_testrun)
	pkurun-fat4way 1 8 $(CR_CMD) --expect-cells 10000 --id=sci03_expect_cells_10k
	pkurun-fat4way 1 8 $(CR_CMD) --expect-cells 100000 --id=sci03_expect_cells_100k
	pkurun-fat4way 1 8 $(CR_CMD) --expect-cells 1000000 --id=sci03_expect_cells_1000k
	pkurun-fat4way 1 8 $(CR_CMD) --force-cells 10000 --id=sci03_force_cells_10K
	pkurun-fat4way 1 8 $(CR_CMD) --force-cells 100000 --id=sci03_force_cells_100K
	pkurun-fat4way 1 8 $(CR_CMD) --force-cells 1000000 --id=sci03_force_cells_1000K
