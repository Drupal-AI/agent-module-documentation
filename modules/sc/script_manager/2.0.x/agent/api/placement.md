# Rendering, formatter & alter hook

## How snippets reach the page

`script_manager.module` implements `hook_page_top()` and `hook_page_bottom()`, each delegating to
`ScriptPlacementManager::getRenderedScriptsForPosition(POSITION_TOP|POSITION_BOTTOM)`.

`ScriptPlacementManager` (service via `ContainerInjectionInterface`, ctor args: `script` storage,
`router.admin_context`->isAdminRoute() bool, module handler):

1. Returns `[]` immediately on **admin routes** (tracking never runs in the admin UI).
2. `loadByProperties(['position' => $position])` to get scripts for that slot.
3. For each script: `$script->access('view', NULL, TRUE)` (evaluates visibility conditions), then builds
   `['#markup' => new FormattableMarkup($script->getSnippet(), []), '#access' => $access->isAllowed()]`
   and attaches cacheable metadata from the access result + the script entity.
4. Adds top-level `#cache` tag `config:script_list`, then invokes
   `hook_script_manager_scripts_alter($rendered_scripts)`.

**The snippet is emitted through `FormattableMarkup($snippet, [])` with no placeholders — it is output raw
and unescaped.** That is intentional (the point is to run real `<script>` tags), and it is why the
`administer scripts` permission is a trusted, `restrict access: true` capability: anyone who can edit a
script can inject arbitrary client-side code site-wide.

## `hook_script_manager_scripts_alter(array &$scripts)`

Invoked once per position with the full render array (indexed children are the per-script
`#markup`/`#access` arrays). Use it to drop, reorder, or wrap rendered scripts, or to add cache metadata.
There is no `*.api.php` file shipped; the hook name is `script_manager_scripts`.

## `script_entity` field formatter

`ScriptEntityFormatter` (`Plugin/Field/FieldFormatter/ScriptEntityFormatter`, id `script_entity`,
label *Script Formatter*) applies to `entity_reference` fields whose `target_type` is `script`. For each
referenced script it renders `['#markup' => new FormattableMarkup($entity->getSnippet(), [])]` — again raw.
This lets you attach a script to content by reference and have it render wherever that field is displayed
(independently of the `top`/`bottom` page placement). The referenced snippet content is still authored by
an `administer scripts` admin.
