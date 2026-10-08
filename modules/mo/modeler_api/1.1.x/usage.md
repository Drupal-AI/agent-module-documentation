Modeler API is a framework that lets graphical modelers (like BPMN.iO) visually edit the configuration entities owned by other modules (ECA workflows, AI agents), fully decoupling *what is modeled* from *how it is modeled*.

---

Modeler API defines two complementary plugin types and mediates between them so any visual editor works with any module's config entities without either side knowing the other exists. A **Model Owner** plugin (`#[ModelOwner]`, namespace `Plugin/ModelerApiModelOwner`, implementing `ModelOwnerInterface`) owns config entities and declares what components exist — events, actions, conditions, gateways — and how models are stored and saved. A **Modeler** plugin (`#[Modeler]`, namespace `Plugin/ModelerApiModeler`, implementing `ModelerInterface`) renders a canvas and parses/serializes its native format (XML, JSON) into generic `Component` value objects. The central `modeler_api.service` (`Api` class) orchestrates the whole save cycle: parse raw modeler data, extract metadata, reset the owner's components, add each component back, finalize, and persist — using 7 generic component types (start, subprocess, swimlane, element, link, gateway, annotation). It auto-generates the admin UI (entity listing, local tasks/actions, menu links), dynamic routes (up to 18 per owner) and granular permissions (up to 11 per owner) from plugin metadata. Raw modeler data can be stored three ways: as third-party settings on the config entity, in a separate config entity, or not at all. Three further YAML-only plugin types — **Context**, **Dependency**, and **Template Token** — let any module curate which components appear, constrain valid orderings, and define template token trees without writing PHP. Models can be imported/exported as `.tar.gz` archives or complete Drupal recipes, and owners can opt into in-modeler testing and execution replay. The module does nothing alone: it needs at least one model owner (ECA via `eca_ui`, AI Agents) and one modeler (BPMN.iO, Workflow Modeler). Settings live at **Admin → Configuration → Workflow → Modeler API** (`modeler_api.settings`), where you pick the modeler and storage method per owner.

---

- Give ECA automation workflows a graphical BPMN editor without ECA writing any editor code.
- Let AI Agents configurations (sub-agents, function-call tools) be edited on a visual canvas.
- Provide one visual editor that works across every model owner on the site (N owners × M modelers = N×M combos, zero glue).
- Write a new **Modeler** plugin to plug a graphical editor (React Flow, BPMN.iO, custom) into all existing model owners.
- Write a new **Model Owner** plugin so your module's config entities become visually editable.
- Switch the active modeler for an owner (e.g. from BPMN.iO to Workflow Modeler) without losing configuration data.
- Choose how raw diagram data is stored per owner/modeler: third-party settings, separate config entity, or not stored.
- Enforce a fixed storage method from the model owner side (`enforceDefaultStorageMethod()`).
- Auto-generate the admin listing, local tasks/actions and menu links for a model-owner entity type.
- Auto-generate up to 18 admin routes and 11 permissions per model owner from plugin definitions.
- Curate which components appear in the modeler per use case via YAML **Context** plugins (`MODULE.modeler_api.contexts.yml`).
- Constrain valid component orderings/successors via YAML **Dependency** plugins.
- Declare cardinality constraints (min/max component counts and successors) via `modelConstraints()`.
- Define reusable model templates with placeholder **Template Token** trees (`MODULE.modeler_api.template_tokens.yml`).
- Let editors apply a template to DOM elements through the Preact-based template selector frontend.
- Export any model as a `.tar.gz` archive with all config dependencies resolved.
- Export a model as a complete Drupal recipe (`composer.json`, `recipe.yml`, config, install instructions).
- Import a model from an archive, a raw modeler file, or a single config YAML.
- Bulk-update all models when their underlying plugins change (`drush modeler_api:update`).
- Enable or disable all models for a given owner from the CLI (`drush modeler_api:enable`/`:disable`).
- Export a model as a recipe from the command line (`drush modeler_api:model:export`).
- Add in-modeler testing (start/poll async test jobs) for a model owner that opts in.
- Offer execution replay, loading trace data per component onto the diagram.
- Embed a modeler canvas into an existing config entity form via `Api::embedIntoForm()`.
- Look up the model owner plugin that owns a given config entity via `Api::findOwner()`.
- Convert an existing owner entity that has no diagram yet into a laid-out model (`ModelerInterface::convert()`).
- Alter discovered plugin definitions of any of the five plugin types via `*_info_alter` hooks.
- Read a model's used components generically (`getUsedComponents()`) regardless of which owner defined them.
- Restrict access to models with the module's dynamic, per-owner permissions.
