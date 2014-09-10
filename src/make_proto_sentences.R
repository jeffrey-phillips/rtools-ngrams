# Create agent-verb-patient proto-sentences.
nsent<-10
proto<-data.frame()
for (i in 1:dim(v16)[1]) {
	if (v16$transitivity[i] %in% c('at','st')) {

		v<-v16$past[i]
		f<-v16$domFeat[i]
		t<-v16$transitivity[i]
		svmed<-v16$svmed[i]
		vomed<-v16$vomed[i]
		svq1<-v16$svq1[i]
		voq1<-v16$voq1[i]
		svq3<-v16$svq3[i]
		voq3<-v16$voq3[i]

		# Coherence=1: A&P from top quartile.
		coh<-1
		sind<-which(qpairs$v==v & qpairs$pmisv>svq3)
		oind<-which(qpairs$v==v & qpairs$pmivo>voq3 & !qpairs$pmivo %in% c(-Inf,Inf))
		if (length(sind)==0) {sind<-NA}
		if (length(oind)==0) {oind<-NA}
		sreplace<-ifelse(length(sind)>=nsent,FALSE,TRUE)
		oreplace<-ifelse(length(oind)>=nsent,FALSE,TRUE)
		tmp<-data.frame(coherence=rep(coh,nsent),feature=rep(f,nsent),transitivity=rep(t,nsent),agent=sample(x=qpairs$n[sind],size=nsent,replace=sreplace),verb=rep(v,nsent),patient=sample(x=qpairs$n[oind],size=nsent,replace=oreplace))
		proto<-rbind(proto,tmp)

		# Coherence=2: A&P from second-highest quartile.
		coh<-2
		sind<-which(qpairs$v==v & qpairs$pmisv>svq3)
		oind<-which(qpairs$v==v & qpairs$pmivo>vomed & qpairs$pmivo<=voq3 & !qpairs$pmivo %in% c(-Inf,Inf))
		if (length(sind)==0) {sind<-NA}
		if (length(oind)==0) {oind<-NA}
		sreplace<-ifelse(length(sind)>=nsent,FALSE,TRUE)
		oreplace<-ifelse(length(oind)>=nsent,FALSE,TRUE)
		tmp<-data.frame(coherence=rep(coh,nsent),feature=rep(f,nsent),transitivity=rep(t,nsent),agent=sample(x=qpairs$n[sind],size=nsent,replace=sreplace),verb=rep(v,nsent),patient=sample(x=qpairs$n[oind],size=nsent,replace=oreplace))
		proto<-rbind(proto,tmp)

		# Coherence=3: A&P from second-highest quartile.
		coh<-3
		sind<-which(qpairs$v==v & qpairs$pmisv>svq3)
		oind<-which(qpairs$v==v & qpairs$pmivo<=vomed & qpairs$pmivo<=voq1 & !qpairs$pmivo %in% c(-Inf,Inf))
		if (length(sind)==0) {sind<-NA}
		if (length(oind)==0) {oind<-NA}
		sreplace<-ifelse(length(sind)>=nsent,FALSE,TRUE)
		oreplace<-ifelse(length(oind)>=nsent,FALSE,TRUE)
		tmp<-data.frame(coherence=rep(coh,nsent),feature=rep(f,nsent),transitivity=rep(t,nsent),agent=sample(x=qpairs$n[sind],size=nsent,replace=sreplace),verb=rep(v,nsent),patient=sample(x=qpairs$n[oind],size=nsent,replace=oreplace))
		proto<-rbind(proto,tmp)

		# Coherence=4: A&P from second-highest quartile.
		coh<-4
		sind<-which(qpairs$v==v & qpairs$pmisv>svq3)
		oind<-which(qpairs$v==v & qpairs$pmivo<=voq1 & !qpairs$pmivo %in% c(-Inf,Inf))
		if (length(sind)==0) {sind<-NA}
		if (length(oind)==0) {oind<-NA}
		sreplace<-ifelse(length(sind)>=nsent,FALSE,TRUE)
		oreplace<-ifelse(length(oind)>=nsent,FALSE,TRUE)
		tmp<-data.frame(coherence=rep(coh,nsent),feature=rep(f,nsent),transitivity=rep(t,nsent),agent=sample(x=qpairs$n[sind],size=nsent,replace=sreplace),verb=rep(v,nsent),patient=sample(x=qpairs$n[oind],size=nsent,replace=oreplace))
		proto<-rbind(proto,tmp)

	}
}


# Create agent-verb proto-sentences, no patient/object.
nsent<-10
avproto<-data.frame()

for (i in 1:dim(v16)[1]) {
	if (v16$transitivity[i] %in% c('in','st')) {

		v<-v16$past[i]
		f<-v16$domFeat[i]
		t<-v16$transitivity[i]
		svmed<-v16$svmed[i]
		vomed<-v16$vomed[i]
		svq1<-v16$svq1[i]
		voq1<-v16$voq1[i]
		svq3<-v16$svq3[i]
		voq3<-v16$voq3[i]

		# Coherence=1: A&P from top quartile.
		coh<-1
		sind<-which(qpairs$v==v & qpairs$pmisv>svq3)
		oind<-which(qpairs$v==v & qpairs$pmivo>voq3 & !qpairs$pmivo %in% c(-Inf,Inf))
		if (length(sind)==0) {sind<-NA}
		if (length(oind)==0) {oind<-NA}
		sreplace<-ifelse(length(sind)>=nsent,FALSE,TRUE)
		tmp<-data.frame(coherence=rep(coh,nsent),feature=rep(f,nsent),transitivity=rep(t,nsent),agent=sample(x=qpairs$n[sind],size=nsent,replace=sreplace),verb=rep(v,nsent))
		avproto<-rbind(avproto,tmp)

	}
}

