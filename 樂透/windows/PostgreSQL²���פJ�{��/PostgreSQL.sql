create table "from_config"
(
   "transport_id"         character varying(10),
   "transport_password"   character varying(45),
   "party_id"             character varying(10) not null,
   "party_description"    character varying(200),
   "routing_id"           character varying(39),
   "routing_description"  character varying(200),
   "sign_id"             character varying(4),
   "substitute_party_id" character varying(10),
   constraint "from_config_pk1" primary key ("party_id")
) ;

create index "from_config_index1"
  on from_config
  using btree
  (substitute_party_id);

create table "turnkey_transport_config" (
  "transport_id" character varying(10) not null,
  "transport_password" character varying(60) not null,
  constraint "turnkey_transport_config_pk1" primary key ("transport_id")
)
;

create table "turnkey_user_profile"
(
  "user_id" character varying(10) not null,
  "user_password" character varying(100) not null,
  "user_role" character varying(2),
  constraint "turnkey_user_profile_pk1" primary key ("user_id")
)
;


insert into "turnkey_user_profile" ("user_id","user_password","user_role") values
 ('ADMIN','ADMIN','0');

create table "schedule_config"
(
  
   "task"                character varying(30) not null,
   "enable"               character varying(1),
   "schedule_type"        character varying(10),
   "schedule_week"        character varying(15),
   "schedule_time"        character varying(50),
   "schedule_period"      character varying(10),
   "schedule_range"       character varying(15),
    constraint "schedule_config_pk1" primary key ("task")
) ;


create table "sign_config" (
  "sign_id" character varying(4) not null,
  "sign_type" character varying(10)  default null,
  "pfx_path" character varying(100)  default null,
  "sign_password" character varying(60)  default null,
  constraint "sign_config_pk1" primary key ("sign_id")
) ;


create table "task_config"
(
   "category_type"        character varying(5) not null,
   "process_type"         character varying(10) not null,
   "task"                 character varying(15) not null,
   "src_path"             character varying(200),
   "target_path"          character varying(200),
   "file_format"          character varying(20),
   "version"              character varying(5),
   "encoding"             character varying(15),
   "trans_chinese_date"   character varying(1),
   constraint "task_config_pk1" primary key ("category_type", "process_type", "task")
);


create table "to_config"
(
   "party_id"             character varying(10) not null,
   "party_description"    character varying(200),
   "routing_id"           character varying(39),
   "routing_description"  character varying(200),
   "from_party_id"        character varying(10),
   constraint "to_config_pk1" primary key ("from_party_id", "party_id")
);


create table "turnkey_message_log" (
  "seqno" character varying(8) not null,
  "subseqno" character varying(5) not null,
  "uuid" character varying(40) default null,
  "message_type" character varying(10) default null,
  "category_type" character varying(5) default null,
  "process_type" character varying(10) default null,
  "from_party_id" character varying(10) default null,
  "to_party_id" character varying(10) default null,
  "message_dts" character varying(17) default null,
  "character_count" character varying(10) default null,
  "status" character varying(5) default null,
  "in_out_bound" character varying(1) default null,
  "from_routing_id" character varying(39) default null,
  "to_routing_id" character varying(39) default null,
  "invoice_identifier" character varying(30) default null,
  constraint "turnkey_message_log_pk1" primary key ("seqno", "subseqno")
)
;

create index "turnkey_message_log_index1"
  on turnkey_message_log
  using btree
  (message_dts);

create index "turnkey_message_log_index2"
  on turnkey_message_log
  using btree
  (uuid);

create table "turnkey_message_log_detail"
(
   "seqno"                character varying(8) not null,
   "subseqno"             character varying(5) not null,
   "process_dts"          character varying(17),
   "task"                 character varying(30) not null,
   "status"               character varying(5),
   "filename"             character varying(300),
   "uuid"                 character varying(40),
   
   constraint "turnkey_message_log_detail_pk1" primary key ("seqno", "subseqno", "task")
)
;

create index "turnkey_message_log_detail_index1"
  on turnkey_message_log_detail
  using btree
  (filename);


create table "turnkey_sequence"
(
   "sequence" character varying(8) not null,
   constraint "turnkey_sequence_pk1" primary key ("sequence")
)
;



create table "turnkey_sysevent_log"
(
   "eventdts"             character varying(17) not null,
   "party_id"             character varying(10),
   "seqno"                character varying(8),
   "subseqno"             character varying(5),
   "errorcode"            character varying(4),
   "uuid"                 character varying(40),
   "information1"         character varying(100),
   "information2"         character varying(100),
   "information3"         character varying(100),
   "message1"             character varying(100),
   "message2"             character varying(100),
   "message3"             character varying(100),
   "message4"             character varying(100),
   "message5"             character varying(100),
   "message6"             character varying(100),
   constraint "turnkey_sysevent_log_pk1" primary key ("eventdts")
)
;

create index "turnkey_sysevent_log_index1"
  on turnkey_sysevent_log
  using btree
  (seqno, subseqno);

create index "turnkey_sysevent_log_index2"
  on turnkey_sysevent_log
  using btree
  (uuid);

