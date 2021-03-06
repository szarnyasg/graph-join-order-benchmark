MATCH (cc:     Complete_cast),
      (cct1:   Comp_cast_type),
      (cct2:   Comp_cast_type),
      (cn:     Company_name),
      (ct:     Company_type),
      (it1:    Info_type),
      (it2:    Info_type),
      (k:      Keyword),
      (kt:     Kind_type),
      (mc:     Movie_company),
      (mi:     Movie_info),
      (mi_idx: Movie_info_idx),
      (t:      Title) 
WHERE cct1.kind = 'crew'
  AND cct2.kind <> 'complete+verified'
  AND cn.country_code <> '[us]'
  AND it1.info = 'countries'
  AND it2.info = 'rating'
  AND k.keyword IN ['murder',
                    'murder-in-title',
                    'blood',
                    'violence']
  AND kt.kind IN ['movie',
                  'episode']
  AND NOT mc.note =~ '.*(USA).*'
  AND mc.note =~ '.*(200.*).*'
  AND mi.info IN ['Sweden',
                  'Germany',
                  'Swedish',
                  'German']
  AND mi_idx.info > '6.5'
  AND t.production_year > 2005
MATCH (t)-[ :IS_KIND_TYPE ]->(kt)
MATCH (t)<-[ :KEYWORD_OF ]-(k)
MATCH (t)<-[ :COMPLETE_CAST_OF ]-(cc)
MATCH (cct1)<-[ :IS_SUBJECT_CAST_TYPE ]-(cc)-[ :IS_STATUS_CAST_TYPE ]->(cct2)
MATCH (t)<-[ :MOVIE_COMPANY_OF ]-(mc)
MATCH (cn)-[ :COMPANY_NAME_OF ]->(mc)-[ :IS_COMPANY_TYPE ]->(ct) 
MATCH (t)<-[ :MOVIE_INFO_OF ]-(mi)-[ :IS_INFO_TYPE ]->(it1)
MATCH (t)<-[ :MOVIE_INFO_IDX_OF ]-(mi_idx)-[ :IS_INFO_TYPE ]->(it2)
RETURN MIN(cn.name) AS movie_company,
       MIN(mi_idx.info) AS rating,
       MIN(t.title) AS complete_euro_dark_movie;
