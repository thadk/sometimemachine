-- ROWID is implicit.
CREATE TABLE osm_changeset (
  user_id INTEGER,
  min_lon REAL,
  min_lat REAL,
  max_lon REAL,
  max_lat REAL,
  msg VARCHAR(512),
  created_at INTEGER,
  closed_at INTEGER,
  num_changes INTEGER
);
