Class {
	#name : #BaselineOfSRT2VTT,
	#superclass : #BaselineOf,
	#category : #BaselineOfSRT2VTT
}

{ #category : #baselines }
BaselineOfSRT2VTT >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Clap' with: [ spec repository: 'github://cdlm/clap-st/src' ];
			package: 'SRT2VTT' ;
			package: 'SRT2VTT-Clap' with: [
				spec requires: #('SRT2VTT' 'Clap') ]]
]
