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
			baseline: 'Clap' with: [ spec repository: 'github://cdlm/clap-st:0224057b82d660a74771ea59862c338d59a0a886/src' ];
			package: 'SRT2VTT' ;
			package: 'SRT2VTT-CLAP' with: [
				spec requires: #('SRT2VTT' 'Clap') ]]
]
