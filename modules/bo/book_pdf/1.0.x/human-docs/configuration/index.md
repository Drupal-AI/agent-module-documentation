# Configuration

Book PDF provides its own permission and a settings form for the PDF output.

## The permission

The module provides its own permission. Grant it at **People → Permissions**
(`/admin/people/permissions`) to the roles that should be allowed to export
books to PDF. This permission controls who is *offered* the export.

## PDF settings

The module ships a settings form for the PDF output (it provides its own config
schema). Use it to configure how the PDF is produced. The exact fields depend on
the version and the PDF library in use — open the form on your site to see the
available options. Because the docs for this niche module do not pin an admin
path, look for its settings link on the Extend page after enabling it, or
consult the module's `README`.
