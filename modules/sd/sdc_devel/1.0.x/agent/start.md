# SDC Devel — agent index

Dev tool that validates Single-Directory Components (definition + Twig) and reports issues in the
admin UI and via Drush. No config, no own permissions (report route uses core perms). Requires
`twig/twig ~3.19`. Not for production runtime — a lint/CI aid.

- **The `drush sdc-devel:validate` command** → [drush/validate.md](drush/validate.md)
- **Add a `twig_validator_rule` plugin** → [plugins/twig-validator-rule.md](plugins/twig-validator-rule.md)

Key facts:
- Report UI at `/admin/reports/ui-components` (routes `sdc_devel.twig_validator[.details|.component]`),
  requirement `access components page + access site reports`. Controller
  `ComponentValidatorOverview`.
- Entry service `sdc_devel.validator` (`Validator`) delegates to `sdc_devel.twig_validator`
  (`TwigValidator`) and `sdc_devel.definition_validator` (`DefinitionValidator`, wraps core
  `ComponentValidator`). Components come from core `plugin.manager.sdc`.
- Plugin type `twig_validator_rule`: attribute `#[TwigValidatorRule]`
  (`src/Attribute/TwigValidatorRule.php`), manager `plugin.manager.twig_validator_rule`, interface
  `TwigValidatorRuleInterface`, base `TwigValidatorRulePluginBase`, dir
  `src/Plugin/TwigValidatorRule/`.
- Messages: `ValidatorMessage` (severity via `RfcLogLevel`, line, source snippet, type).
