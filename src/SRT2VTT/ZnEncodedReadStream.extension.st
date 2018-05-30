Extension { #name : #ZnEncodedReadStream }

{ #category : #'*SRT2VTT' }
ZnEncodedReadStream >> upToAny: aCol [ 	
	^ self collectionSpecies 
		streamContents: [ :out | | element |
			[ self atEnd or: [ aCol includes: (element := self next) ] ] whileFalse: [ 
				out nextPut: element ] ]
]
