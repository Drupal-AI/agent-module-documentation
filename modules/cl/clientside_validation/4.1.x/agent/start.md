# clientside_validation — agent start

Adds in-browser validation to Drupal forms. The **base module** only decorates form elements
with `data-rule-*` / `data-msg-*` (and HTML5) attributes via `hook_form_alter()` + an
`#after_build` recurse; the **`clientside_validation_jquery`** submodule loads the jQuery
Validate engine that actually enforces them. Base module has **no config UI** of its own
(`configure` is `null`) and no permissions/Drush commands.

- Enable the engine & how validation is wired → [configure/clientside_validation.md](configure/clientside_validation.md)
- Add a custom validation rule (`CvValidator` plugin type) → [plugins/clientside_validation.md](plugins/clientside_validation.md)
- Skip validation / alter validator info (hooks) → [hooks/clientside_validation.md](hooks/clientside_validation.md)
- jQuery engine submodule (settings, library install, Drush) → [../../modules/clientside_validation_jquery/4.1.x/agent/start.md](../../modules/clientside_validation_jquery/4.1.x/agent/start.md)
