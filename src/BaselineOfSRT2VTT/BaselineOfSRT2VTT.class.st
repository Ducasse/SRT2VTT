Class {
	#name : #BaselineOfSRT2VTT,
	#superclass : #BaselineOf,
	#category : #BaselineOfSRT2VTT
}

{ #category : #baselines }
BaselineOfSRT2VTT >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
		baseline: 'Clap' with: [ spec repository: 'github://cdlm/clap-st' ];
		package: 'SRT2VTT' ]
]
