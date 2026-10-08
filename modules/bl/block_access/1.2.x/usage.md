Block Access adds per-block-type permissions ("create/edit own/delete own <type> block content") so non-admin users can manage content blocks without the all-powerful "Administer blocks" permission.

---

Core's Block Content module historically gated all custom (content) block management behind the single, coarse `administer blocks` permission. Block Access supplements that by generating a small set of granular, per-block-content-type permissions through a `permission_callbacks` entry (`\Drupal\block_access\Permissions::get`), which loops over every `block_content` type and emits permissions like `update own <type> block_content` and `delete own <type> block_content` (plus deprecated `create`/`update any`/`delete any` variants kept only for BC). A route subscriber (`block_access.route_subscriber`) rewrites the `block_content.add_form` route to use a custom access check (`_block_content_access_create`) so that creating a block is allowed for users holding either `administer blocks` or `create <type> block_content`. The module ships no admin UI, no config, and no configure route — you use it purely by granting its permissions on the People → Permissions page (or in `user.role.*` config). Newer Drupal core provides its own per-type content-block permissions, so the module's `create`, `update any` and `delete any` permissions are deprecated in `block_access:8.x-1.2` and removed in `2.0.0`; an update hook (`block_access_update_8001`) migrates roles to the equivalent core permissions where possible. The lasting value in 1.2.x is the "own"-scoped permissions (`update own` / `delete own`) that core does not provide.

---

- Let an editor role edit only its own content blocks without granting `administer blocks`.
- Let a role delete only the content blocks it created (`delete own <type> block_content`).
- Grant block-creation rights for a single block type while withholding others.
- Replace the coarse `administer blocks` permission with narrowly-scoped block permissions.
- Give a "Marketing" role rights over a `promo`/`banner` block type but nothing else.
- Allow content authors to add reusable blocks but not edit site configuration.
- Restrict who can create blocks of a specific custom type via the rewritten add-form access check.
- Provide "own content" ownership semantics for content blocks, mirroring node permissions.
- Delegate management of a `basic` content block type to a limited editor role.
- Build a least-privilege permission set for block editors on a multi-role site.
- Combine `create <type> block content` (core) with `update own <type> block_content` (this module) for a full author workflow.
- Migrate legacy sites off `administer blocks` onto per-type block permissions.
- Let Layout Builder users manage inline/reusable blocks without full block admin access.
- Segregate block permissions by department or content team.
- Prevent junior editors from touching blocks they did not author.
- Grant block-add access to a role using the module's `_block_content_access_create` check.
- Audit and tighten who can create/edit/delete content blocks on an existing site.
- Configure per-type block permissions entirely through exported `user.role.*` config.
- Support an approval workflow where authors edit own blocks and a lead edits any (with core's `edit any`).
- Roll out granular block permissions across many block content types at once (permissions are generated per type).
- Keep block management out of the hands of roles that only need content authoring.
- Provide a stepping stone toward core's native per-type content-block permissions.
- Enable safe delegation of promotional/CTA block editing to marketing staff.
- Scope deletion rights so editors can remove their own drafts of reusable blocks only.
