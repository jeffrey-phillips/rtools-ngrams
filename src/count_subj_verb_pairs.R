setwd('~/krns/ngramtools-read-only/verb_obj')
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
		qpairs$vojoint[qpairs$v==v & qpairs$n==n]<-tot
	}
}
