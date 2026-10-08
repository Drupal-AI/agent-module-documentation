Progressively Decoupled Blocks (PDB) lets front-end developers ship JavaScript-framework components (React, Vue, Ember, Web Components, plain JS) as ordinary placeable Drupal blocks, so islands of framework-driven UI can be dropped into an otherwise server-rendered Drupal page.

---

PDB scans the codebase for "components" — directories containing an info file whose `type: pdb` (rather than `module`/`theme`) — and treats each as a lightweight extension. A `ComponentDiscovery` service (extending core's `ExtensionDiscovery`) finds them either globally or in directories you supply through `Settings::get('pdb_search_dirs')` in `settings.php` or a `PdbDiscoveryEvent` (`pdb.search_dirs`) subscriber. Each discovered component's info (`machine_name`, `presentation`, `add_js`/`add_css`, `settings`, `contexts`, `configuration`, `status`) is turned into a block plugin by `PdbBlockDeriver`, so every component appears in Block layout and Layout Builder. `pdb_library_info_build()` builds header/footer asset libraries from the component's declared JS/CSS (supporting local and `type: external` assets), always depending on the `pdb_<presentation>/<presentation>` framework library provided by a presentation submodule (e.g. `pdb_react`, `pdb_vue`, `pdb_ember`, `pdb_default` — separate projects). At render time the abstract `PdbBlock` attaches the framework, the component libraries, any `settings`, and a generated `uuid`, and marshals declared context values (entities are cloned and access-filtered field-by-field before being exposed) into `drupalSettings.pdb`. Component config entered on the block form is stored under the block's `pdb_configuration` (schema `block.settings.pdb`) and passed to the front-end via `drupalSettings.pdb.configuration[uuid]`. PDB itself is a framework: it provides no concrete blocks on its own — you install a presentation module plus your own component code.

---

- Embed a React/Vue/Ember/Web-Component widget into a Drupal page as a placeable block.
- Progressively decouple just part of a page (an "island") while leaving the rest server-rendered.
- Expose a design-system component library to site builders as blocks in Block layout.
- Drop framework components into Layout Builder layouts alongside normal Drupal blocks.
- Ship a front-end component as a self-contained folder (`*.info.yml` with `type: pdb` + JS/CSS) instead of a full module.
- Load component JS/CSS in the header or footer via the component's `add_js`/`add_css` info keys.
- Reference external (CDN) framework or component assets with `type: external` entries.
- Pass configuration entered by a site builder on the block form into a JS component via `drupalSettings`.
- Provide per-instance component settings forms driven by the component's `configuration` info key.
- Feed Drupal context (e.g. the current node/user entity) into a front-end component through block context definitions.
- Safely expose entity data to JS with field-by-field view-access filtering before it reaches `drupalSettings`.
- Restrict component discovery to specific directories via `$settings['pdb_search_dirs']` for performance.
- Add custom component search paths at runtime with a `PdbDiscoveryEvent` (`pdb.search_dirs`) subscriber.
- Alter or augment discovered component metadata with `hook_component_info_alter()`.
- Disable a component without removing its files by setting `status: disabled` in its info file.
- Give each rendered component a unique DOM/id anchor via the auto-generated block `uuid`.
- Reuse one component across many pages by placing its derived block multiple times.
- Build a multi-framework front end (mix React and Vue components) on a single Drupal site.
- Serve component assets grouped into header/footer libraries that automatically depend on the framework runtime.
- Migrate a legacy jQuery widget to a maintained framework component while keeping the same block slot.
