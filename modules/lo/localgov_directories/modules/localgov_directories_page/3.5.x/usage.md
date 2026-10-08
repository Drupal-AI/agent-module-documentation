<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories Page provides the plain, structured directory **entry** content type: a node bundle with name, address, contact details, files and facet selection, ready to be posted into a directory channel.

---

This is the reference entry type for LocalGov Directories and the one most sites start with. It installs the `localgov_directories_page` node type together with a full set of field instances reusing the parent module's shared field storages — `localgov_directory_name`, `localgov_directory_address`, `localgov_directory_phone`, `localgov_directory_email`, `localgov_directory_website`, `localgov_directory_job_title`, `localgov_directory_files`, `body`, plus the two fields that make a node an entry at all: `localgov_directory_channels` (which channels it appears in) and `localgov_directory_facets_select` (its facet values). A `localgov_directory_title_sort` field keeps alphabetical listings correct regardless of leading articles. Five view displays ship with it — default, teaser, `directory_index`, `search_index` and `search_result` — so the entry renders correctly in the channel listing, in the index and in search results without any display configuration. Field Group organises the edit form, a pathauto pattern gives entries tidy URLs, and `hook_install()` registers the bundle with Simple XML Sitemap when that module is present (a workaround for a known `config/optional` limitation). `hook_localgov_roles_default()` grants the LocalGov editor and author roles the usual create/edit/delete/revision permissions for the bundle.

---

- Add a straightforward listing entry to a council directory.
- Publish contact details for a team or service in a searchable list.
- Record a person entry with name, job title and phone number.
- List partner organisations with website and email links.
- Attach documents (leaflets, forms) to a directory entry.
- Post the same entry into several directory channels at once.
- Tag entries with facet values so visitors can filter them.
- Keep alphabetical ordering correct with the title-sort field.
- Render entries consistently in listings, search results and the index.
- Give entries clean URLs via the shipped pathauto pattern.
- Include directory entries in the XML sitemap automatically.
- Let editors manage entries without extra permission setup on LocalGov sites.
- Use the bundle as a template when building a custom entry type.
- Provide a simple entry type alongside richer venue or promo types.
- Capture a structured postal address using the Address module.
- Present grouped fields on the edit form with Field Group.
- Support multiple contact methods on one entry.
- Migrate legacy directory data into a standard bundle.
- Keep entry content editable by editors while site config stays exported.
- Serve as the default choice when a channel needs a generic entry type.
