MATCH (an: Aka_name),
      (ci: Cast_info),
      (it: Info_type),
      (lt: Link_type),
      (ml: Movie_link),
      (n:  Name),
      (pi: Person_info),
      (t:  Title)
WHERE an.name =~ '.*a.*'
  AND it.info = 'mini biography'
  AND lt.link = 'features'
  AND n.name_pcode_cf =~ 'D.*'
  AND n.gender = 'm'
  AND pi.note ='Volker Boehm'
  AND 1980 <= t.production_year <= 1984
MATCH (t)<-[ :LINKED_TO ]-(ml)-[ :IS_LINK_TYPE ]->(lt)
MATCH (t)<-[ :CAST_IN ]-(ci)<-[ :CAST_AS ]-(an)-[ :NAME_OF ]->(n)
MATCH (n)<-[ :PERSON_INFO_OF ]-(pi)-[ :IS_INFO_TYPE ]->(it)
RETURN MIN(n.name) AS of_person,
       MIN(t.title) AS biography_movie;
