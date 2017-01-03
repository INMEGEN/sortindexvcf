SORTINDEXVCF = `{./targets}

sortindexvcf:VE:	$SORTINDEXVCF

results/sortindexvcf/%.sorted.vcf.gz.tbi:	results/sortindexvcf/%.sorted.vcf.gz
	mkdir -p `dirname $target`
	tabix -p vcf $prereq

results/sortindexvcf/%.sorted.vcf.gz:	data/%.vcf.gz
	mkdir -p `dirname $target`
	zcat $prereq \
	| vcf-sort \
	| bgzip -c \
	> $target.build \
	&& mv $target.build $target

data/%.vcf.gz:	data/%.vcf
	bgzip $prereq
