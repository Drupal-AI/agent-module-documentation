<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command: `readme-generate`

Defined in `Commands\ReadmeGeneratorCommands` (registered via `drush.services.yml`,
service id `ai_readme_generator.commands`, args `@module_handler`, `@config.factory`).

## Usage

```bash
drush readme-generate <module_machine_name>
```

Attribute: `#[CLI\Command(name: 'readme-generate', …)]` with a single required argument
`module` (the module's machine name).

## Behaviour (`generate()`, from source)

1. Looks for the module directory in, in order, `modules/custom/<module>` then
   `modules/contrib/<module>` (relative paths, `is_dir()` check). If neither exists it
   prints a "not found" message and returns.
2. Runs `CodebaseScanner($module_path)->scan()`.
3. Reads `ai_readme_generator.settings` and requires `api_key`, `chat_endpoint` and
   `model` to be set — otherwise prints *"Please fill the AI configuration form first!"*.
4. Calls `AIResponse($config)->summarizeArray($moduleData)`.
5. Writes the result with `file_put_contents($module_path . '/README.md', $summary)` and
   prints the path.

## Notes

- Configure the provider/key/model first via
  `/admin/config/ai-readme-generator` (see [../config/settings.md](../config/settings.md)).
- Unlike the UI form (which locates modules via `ExtensionDiscovery`), the Drush command
  only checks `modules/custom` and `modules/contrib`; a module elsewhere (e.g. a
  profile's modules dir) won't be found by the command.
- Running Drush already implies shell/site access, so the command runs with full
  operator privileges.
