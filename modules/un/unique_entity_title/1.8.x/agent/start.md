# Unique Entity Title — agent index

Enforces unique node titles and taxonomy term names within a bundle by attaching a
`UniqueEntityTitle` validation constraint. Opt-in per content type / vocabulary via a
`third_party_settings` flag. No central config form, no permissions, no Drush.

Supported entity types: `node` (title field) and `taxonomy_term` (name field) only.

- Enable/disable uniqueness per bundle and how the constraint works: [configure/configure.md](configure/configure.md)
