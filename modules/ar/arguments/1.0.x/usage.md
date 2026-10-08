Arguments (Pros/Cons) lets visitors attach PRO and CONTRA argument entities to a node so an open question can be debated and vote-weighted.

---

The module defines a revisionable, translatable `argument` content entity that references a parent node (the "rule"/open question). Each argument carries a type (PRO or CONTRA), a short title, and a long text body, plus authorship and publishing status. A context-aware "Argumentation" block, placed on enabled node types, renders the arguments for the current node in two columns (pro vs. contra), offers an "Add argument" link, and — via the required Vote module — a client-side sorter that orders arguments by their vote result. Configuration lives in the `arguments.settings` config object: which node types are argument-enabled, default revisioning, and length limits. Access is governed entirely by a set of module-defined permissions (add/edit/delete/view/administer and revision permissions) enforced through a dedicated entity access control handler. Part of the "RulesFinder" package; it also ships an optional field formatter that integrates with the separate `change_requests` module when present.

---

- Enable pro/con debate on decision or policy nodes (e.g. "Should we adopt X?").
- Let authenticated users submit short, titled arguments for or against a node's question.
- Display arguments grouped into two columns — Pro Arguments and Contra Arguments — beside the node.
- Weight and re-order arguments by community votes using the companion Vote module.
- Restrict which content types can receive arguments via the settings form (`arguments_node_types`).
- Add an "Add argument" call-to-action button to a node for users who may create arguments.
- Cap argument body length site-wide (`max_argument_text_length`) with form validation.
- Cap the argument title length (`max_argument_name_length`).
- Keep a full revision history of every argument, with revert and delete of prior revisions.
- Force new-revision-on-edit by default while letting privileged roles omit revisions.
- Translate arguments into multiple site languages (the entity is translatable).
- Publish or unpublish individual arguments, gating who can see unpublished ones.
- Show a "pro:contra" count chip in a node's meta area (via the `rufi_meta_node_rule` hook).
- Redirect a stray canonical argument URL back to its parent node, scrolling to the argument.
- Provide an admin overview list of all argument entities under Content administration.
- Expose argument data to Views for building custom argument listings and reports.
- Build role-based moderation: separate permissions for editing, deleting, and reverting arguments.
- Place the Argumentation block through Block layout with an optional introduction text.
- Mark newly added arguments as "new" for authenticated users when the History module is on.
- Use the settings link under Structure to manage argument fields, form display, and view modes.
- Attach a "change requests" formatter to related patch fields when the `change_requests` module is installed.
- Seed a discussion UI on any node type without writing custom code, purely through configuration.
