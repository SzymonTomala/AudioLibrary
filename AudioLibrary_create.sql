create table TypeOfAudio(
id number generated always as identity,
Type varchar(32) not null check(Type in('Song', 'AudioBook','Podcast')));

create table AudioFile (
id number generated always as identity,
Title varchar(64) not null,
AuthorId number not null,
TypeOfAudioId number not null,
Length int not null);

create table Author (
id number generated always as identity,
AuthorName varchar(64) not null;

create table AudioUser(
id number generated always as identity,
FirstName varchar(64) not null,
LastName varchar(64) not null,
Email varchar(64) not null,
Pass varchar(64) not null);

create table Playlist(
id number generated always as identity,
AudioUserId number not null);


create table Likes(
id number generated always as identity,
AudioUserId number not null,
AudioFileId number not null,
PlaylistId number not null);


--###RELATIONS###
    --###PRIMARY KEYS###
alter table TypeOfAudio add constraint pk_TypeOfAudios
primary key (id);
alter table AudioFile add constraint pk_AudioFiles
primary key (id);
alter table Author add constraint pk_Authors
primary key (id);
alter table AudioUser add constraint pk_AudioUsers
primary key (id);
alter table Playlist add constraint pk_Playlists
primary key (id);
alter table Likes add constraint pk_Likes
primary key (id);

--###FOREIGN KEYS###
alter table AudioFile add constraint fk_Author
foreign key (AuthorId) references Author(id);

alter table AudioFile add constraint fk_TypeOfAudio
foreign key (TypeOfAudioId) references TypeOfAudio(id);

alter table Playlist add constraint fk_AudioUserPlaylist
foreign key (AudioUserId) references AudioUser(id);

alter table Likes add constraint fk_AudioUser
foreign key (AudioUserId) references AudioUser(id);

alter table Likes add constraint fk_AudioFile
foreign key (AudioFileId) references AudioFile(id);

alter table Likes add constraint fk_Playlist
foreign key (PlaylistId) references Playlist(id);




