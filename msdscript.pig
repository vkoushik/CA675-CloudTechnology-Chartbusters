songstable  = LOAD 's3://msdbucketdcu/10000song.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',','YES_MULTILINE') AS (SongNumber:int,SongID:chararray,AlbumID:int,AlbumName:chararray,ArtistId:chararray,ArtistLatitude:chararray,ArtistLocation:chararray,ArtistLongitude:chararray,ArtistName:chararray,Danceability:chararray,Duration:float,KeySignature:int,KeySignatureConfidence:float,Tempo:Float,TimeSignature:int,TimeSignatureConfidence:float,Title:chararray,Year:int,track_id:chararray,artist_hotttnesss:float,artist_mbid:chararray,artist_playmeid:chararray,artist_7digitalid:int,release:chararray,release_7digitalid:int,song_hotttnesss:float,track_7digitalid:int,analysis_sample_rate:int,audio_md5:chararray,end_of_fade_in:float,energy:chararray,key:int,key_confidence:float,loudness:chararray,mode:int,mode_confidence:float,start_of_fade_out:float); 


genretable = LOAD 's3://msdbucketdcu/msd_tagtraum_cd2c.cls' USING PigStorage('\t') AS (track_id:chararray,genre:chararray);

merge = JOIN songstable BY track_id LEFT OUTER,genretable BY track_id;


STORE merge INTO 's3://msdbucketdcu/songsandgenre' USING PigStorage('~');
