# drush — code generator (not a runtime command)

AI Automators does **not** add operational drush commands. Its `src/Drush/` provides a Drupal
Code **generator** that plugs into `drush generate`, to scaffold a new Automator Type plugin.

## `drush generate plugin:ai:automator-type` (alias `ai-automator-type`)

```bash
drush generate plugin:ai:automator-type
# or
drush generate ai-automator-type
```

Interactive prompts (from `AiAutomatorTypeGenerator`):
| Prompt | Meaning |
|---|---|
| Module machine name | target module to write the plugin into |
| Plugin label / plugin id / class | names for the new `AiAutomatorType` plugin |
| Field rule (target field type) | chosen from the site's installed field types — sets `field_rule` |
| Target entity type | for `entity_reference`/`file` rules; leave empty otherwise |
| Base class to extend | picked from `src/PluginBaseClasses/` (e.g. `ComplexTextChat`, `RuleBase`) |
| Does this automator need a prompt? | yes/no |

Output: `src/Plugin/AiAutomatorType/{Class}.php` in the chosen module (template
`templates/Plugin/_ai-automator-type/ai-automator-type.twig`). Then customize the generated
class — see [../plugins/ai_automators.md](../plugins/ai_automators.md).

For sending ad-hoc chat or other runtime AI actions, use AI Core's `drush ai:chat` (documented
under the parent `ai` module), not this submodule.
