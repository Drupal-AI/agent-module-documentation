Views Autocomplete API demo is an example submodule that wires two sample Views to the core search block to demonstrate Views Autocomplete API.

---

This submodule exists only to show the parent module in action. It ships two example Views in `config/install` (`search_auto_publish` and `search_auto_unpublish`), a `hook_install()` that creates two sample article nodes, and a single `hook_form_search_block_form_alter()` that turns the core search block's field into an autocomplete pointing at the `views_autocomplete_api` route with `view_name = 'search_auto_publish,search_auto_unpublish'` and `display_id = ',block_1'`. Enable it on a scratch/demo site to see how a `form_alter` plus a View produces suggestions; it is a reference implementation, not a production feature, and you would normally copy the pattern into your own module rather than keep the demo enabled.

---

- See a working Views Autocomplete API integration end to end.
- Learn the `hook_form_search_block_form_alter()` pattern for the core search block.
- Study how to pass a multi-View `view_name` and per-View `display_id` list.
- Inspect two example Views set up as autocomplete sources.
- Get sample article content to test suggestions against.
- Copy the `#autocomplete_route_name` / `#autocomplete_route_parameters` wiring into a custom module.
- Demo typeahead over the core search block on a sandbox site.
- Verify the parent module is installed and functioning.
- Use as a template when building your own Views-backed autocomplete.
- Understand how display ids can be omitted with an empty comma-separated entry.
- Show colleagues how little code a Views autocomplete needs.
- Reproduce issues for the project's issue queue.
- Confirm the autocomplete route resolves and returns JSON.
- Explore the exported Views config that the module expects.
- Prototype before writing production autocomplete code.
