<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tripal — extension framework

## Plugin types
- **TripalImporter** — data loaders shown in the Data Loaders UI; implement to ingest a file/format into Tripal/Chado.
- **TripalStorage** / **TripalField** — the field storage backend that maps fields to controlled-vocabulary terms (term-driven storage rather than fixed SQL columns).
- **TripalVocabulary / TripalVocabTerms** — controlled-vocabulary providers and term id-spaces.
- **TripalPubLibrary / TripalPubParser** — publication source connectors and parsers.

## TripalDBX
`src/TripalDBX` is a cross-database abstraction for talking to the external Chado PostgreSQL schema alongside the Drupal database. It builds parameterised queries (`information_schema`, `pg_indexes`, `pg_tables` introspection) and deserialises stored schema definitions with `unserialize($schema, ['allowed_classes' => FALSE])`.

## Jobs
`src/Services/TripalJob` + `tripal.jobs.api.php` provide the background-job engine (submit, run, cancel, rerun). Job `arguments`/`callback`/`includes` are stored serialized and unserialized at run time — these records are written by admin operations, not by anonymous requests.

## API layer
`src/api/*.api.php` exposes procedural helpers (jobs, uploads, chado, etc.). `TripalFieldCollection` and related services discover and attach fields to Tripal content types.

## Dev/test
Multiple PHPUnit configs (`phpunit.9/10/11.xml`) and `set_phpunit_config.sh`; `tripaldocker/` provides a container-based dev/CI stack across the supported Drupal/PHP/PostgreSQL matrix.
