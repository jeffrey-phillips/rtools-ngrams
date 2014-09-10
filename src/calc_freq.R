# Calculate PMI for subject-verb pairs.
qpairs<-qpairs[order(qpairs$v,qpairs$n),]
qpairs$svjoint<-NA
setwd('~/krns/ngramtools-read-only/verbs')
for (f in Sys.glob('*txt')) {
	v<-gsub('.txt','',f)
	df<-readLines(con=f)
	for (n in nn$concept) {
		print(paste(v,n,sep=' | '))
		subdf<-df[grep(paste(' ',n,' ',sep=''),df)]
		tot<-0
		if (length(subdf)>0) {
			include<-rep(TRUE,length(subdf))
			for (i in 1:length(subdf)) {
				l<-subdf[i]
				l<-unlist(strsplit(x=l,split=' '))
				l<-l[grepl('\\|',l) & grepl('NN',l) & grepl('VBD',l)]
				if (length(l)==0) { include[i]<-FALSE }
				for (x in l) {
					x<-unlist(strsplit(x,'\\|'))
					tot<-tot+as.numeric(x[length(x)])
				}
			}
			# Write out a file in subj_verb_pairs directory with the subset of lines that contributed to the calculation.
			write.table(file=paste('~/krns/ngramtools-read-only/subj_verb_pairs/',n,'_',v,'.txt',sep=''),subdf[include],row.names=F,quote=F,sep='\t')
		} else {
			# Write out a blank text file.
			subdf<-''; write.table(file=paste('~/krns/ngramtools-read-only/subj_verb_pairs/',n,'_',v,'.txt',sep=''),subdf,row.names=F,quote=F,sep='\t')					
		}
		qpairs$svjoint[qpairs$v==v & qpairs$n==n]<-tot
	}
}

# Raw word frequencies.
qpairs$fv<-verbfreq$freq[match(qpairs$v,verbfreq$word)]
qpairs$fns<-nounfreq$freq[match(qpairs$n,nounfreq$word)]
qpairs$fno<-nobjfreq$freq[match(qpairs$n,nobjfreq$word)]

# Word probabilities, defined as word count over sum of counts for all words.
qpairs$pv<-verbfreq$freq[match(qpairs$v,verbfreq$word)]/sum(verbfreq$freq)
qpairs$pns<-nounfreq$freq[match(qpairs$n,nounfreq$word)]/sum(nounfreq$freq)
qpairs$pno<-nobjfreq$freq[match(qpairs$n,nobjfreq$word)]/sum(nobjfreq$freq)

# Conditional probabilities of nouns, defined as noun+verb count over verb count.
qpairs$cpsv<-qpairs$svjoint/qpairs$fv
qpairs$cpvo<-qpairs$vojoint/qpairs$fv

# Pointwise mutual information, defined as 
qpairs$pmisv<-log(qpairs$cpsv/qpairs$pns,base=2)
qpairs$pmivo<-log(qpairs$cpvo/qpairs$pno,base=2)

# Normalized PMI
qpairs$npmisv<-qpairs$pmisv/(-log(qpairs$pv*qpairs$cpsv)	)
qpairs$npmivo<-qpairs$pmivo/(-log(qpairs$pv*qpairs$cpvo))

# Characterize the range of PMI values for each verb.

vbset$svnneginf<-0
vbset$svninf<-0
vbset$svnreal<-0
vbset$svmin<-NA
vbset$svq1<-NA
vbset$svmed<-NA
vbset$svmean<-NA
vbset$svq3<-NA
vbset$svmax<-NA
for (i in 1:dim(vbset)[1]) {
	v<-vbset$past[i]
	vbset$svnneginf[i]<-length(qpairs$pmisv[qpairs$v==v & qpairs$pmisv==-Inf])
	vbset$svninf[i]<-length(qpairs$pmisv[qpairs$v==v & qpairs$pmisv==Inf])
	indreal<-which(qpairs$v==v & !qpairs$pmisv %in% c(Inf,-Inf,NaN))
	vbset$svnreal[i]<-length(indreal)
	vbset[i,c('svmin','svq1','svmed','svmean','svq3','svmax')]<-as.numeric(summary(qpairs$pmisv[indreal]))
}

vbset$vonneginf<-0
vbset$voninf<-0
vbset$vonreal<-0
vbset$vomin<-NA
vbset$voq1<-NA
vbset$vomed<-NA
vbset$vomean<-NA
vbset$voq3<-NA
vbset$vomax<-NA
for (i in 1:dim(vbset)[1]) {
	v<-vbset$past[i]
	vbset$vonneginf[i]<-length(qpairs$pmivo[qpairs$v==v & qpairs$pmivo==-Inf])
	vbset$voninf[i]<-length(qpairs$pmivo[qpairs$v==v & qpairs$pmivo==Inf])
	indreal<-which(qpairs$v==v & !qpairs$pmivo %in% c(Inf,-Inf,NaN))
	vbset$vonreal[i]<-length(indreal)
	vbset[i,c('vomin','voq1','vomed','vomean','voq3','vomax')]<-as.numeric(summary(qpairs$pmivo[indreal]))
}

vbset$ngramprob<-qpairs$pv[match(vbset$past,qpairs$v)]
vbset$ngramcount<-qpairs$fv[match(vbset$past,qpairs$v)]

