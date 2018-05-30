Class {
	#name : #SRT2VTTTest,
	#superclass : #TestCase,
	#category : #SRT2VTT
}

{ #category : #sample }
SRT2VTTTest class >> srtSample [ 

	^ '1
00:00:07,040 --> 00:00:10,440
Hello. This week,
we''ll get to the heart of the matter,

2
00:00:10,600 --> 00:00:12,160
about syntax especially.

3
00:00:12,320 --> 00:00:17,560
This class will be mostly about dealing
with the messages of Pharo''s syntax,

4
00:00:17,720 --> 00:00:19,560
which is most of Pharo.

5
00:00:20,400 --> 00:00:23,840
In Pharo, there are three main things:

6
00:00:24,000 --> 00:00:28,040
objects, messages,
and closures called blocks.

7
00:00:28,200 --> 00:00:30,200
There''ll be a course about blocks.'
]

{ #category : #sample }
SRT2VTTTest class >> srtSampleShorter [

	^ '35
00:01:55,520 --> 00:01:56,720
Disfrute.'
]

{ #category : #tests }
SRT2VTTTest >> testGo [
	| srt |
	srt := SRT2VTT new in: self class srtSample readStream.
	srt go.
	srt out contents
= 'WEBVTT

00:00:07.040 --> 00:00:10.440 align:middle
Hello. This week,
we''ll get to the heart of the matter,

00:00:10.600 --> 00:00:12.160 align:middle
about syntax especially.

00:00:12.320 --> 00:00:17.560 align:middle
This class will be mostly about dealing
with the messages of Pharo''s syntax,

00:00:17.720 --> 00:00:19.560 align:middle
which is most of Pharo.

00:00:20.400 --> 00:00:23.840 align:middle
In Pharo, there are three main things:

00:00:24.000 --> 00:00:28.040 align:middle
objects, messages,
and closures called blocks.

00:00:28.200 --> 00:00:30.200 align:middle
There''ll be a course about blocks.

'
]

{ #category : #tests }
SRT2VTTTest >> testIsEmptyLine [
	| srt |
	srt := SRT2VTT new in: self class srtSample readStream.
	srt readLine.
	srt readLine.
	srt readLine.
	srt readLine.
	srt readLine.
	self assert: srt isEmptyLine
]

{ #category : #tests }
SRT2VTTTest >> testLine [

	| srt |
	srt := SRT2VTT new in: self class srtSample readStream.
	self assert: srt readLine equals: '1'
]

{ #category : #tests }
SRT2VTTTest >> testLineIsInteger [
	| srt |
	srt := SRT2VTT new in: self class srtSample readStream.
	srt readLine. 
	
	self assert: srt isIntegerLine 
]

{ #category : #tests }
SRT2VTTTest >> testReadLine [
	| srt |
	srt := SRT2VTT new in: self class srtSample readStream.
	self assert: srt readLine equals: '1'
]

{ #category : #tests }
SRT2VTTTest >> testTreatOneBlock [
	| srt |
	srt := SRT2VTT new in: self class srtSample readStream.
	srt
		emitWebVTTLine;
		treatOneBlock.
	srt out contents
		=
			'WEBVTT

00:00:07.040 --> 00:00:10.440 align:middle
Hello. This week,
we''ll get to the heart of the matter,
'
]

{ #category : #tests }
SRT2VTTTest >> testTreatOneBlockLessLine [
	| srt |
	srt := SRT2VTT new in: self class srtSampleShorter readStream.
	srt
		emitWebVTTLine;
		treatOneBlock.
	srt out contents
		=
			'WEBVTT

00:01:55.520 --> 00:01:56.720 align:middle
Disfrute.'
]
