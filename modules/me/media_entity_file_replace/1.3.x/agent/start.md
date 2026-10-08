# media_entity_file_replace — agent start

Adds a "Replace file" widget to media edit forms for file-based media types (source is a
File field), letting editors overwrite the source file in place (same filename/path) or
replace it with a new filename. Pure form-alter module: no config UI, no permissions, no
services, no plugins. Depends on core `media`.

- Enable & use the "Replace file" widget → [configure/replace-widget.md](configure/replace-widget.md)
