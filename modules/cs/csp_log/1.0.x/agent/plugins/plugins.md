# Provided plugin: Dedicated CSP log reporting handler

csp_log does **not define its own plugin type**. It *provides an instance* of the
`CspReportingHandler` plugin type owned by the [csp](https://www.drupal.org/project/csp)
module, so the csp module must be installed for this plugin to appear.

## The plugin

`src/Plugin/CspReportingHandler/DedicatedLog.php`, extends
`\Drupal\csp\Plugin\ReportingHandlerBase`.

```
@CspReportingHandler(
  id = "csp_log",
  label = @Translation("Dedicated CSP log"),
  description = @Translation("Reports will be added to a dedicated log, provided by the csp_log module."),
)
```

On the CSP policy form it shows up as the **"Dedicated CSP log"** reporting handler
choice for the enforce and report-only policies.

## What it does

- `getForm()` — adds a single field `cleanup` (`#type` number, title "Log lifetime (days)",
  default `0`, min 0). Description: number of days to keep logs before removal; `0` = keep
  indefinitely. Required only when the policy is enabled and this handler is selected.
- `alterPolicy(Csp $policy)` — sets the policy's `report-uri` directive to
  `Url::fromRoute('csp_log.reporturi', ['type' => $type], ['absolute' => TRUE])`, where
  `$type` is `enforce` for the enforce policy, otherwise `reportOnly`. This is what makes
  browser CSP reports POST to this module's endpoint automatically.

## Config schema

`config/schema/csp_log.schema.yml` defines `csp_reporting_handler.csp_log` (mapping with
integer `cleanup`, label "Log lifetime (days)"). The value is persisted by the csp module
under `csp.settings` at `<policy>.reporting.options.cleanup` and consumed by
`csp_log_cron()`.

## Implementing your own handler

To create an alternative reporting handler you implement the csp module's plugin type, not
anything in csp_log — subclass `\Drupal\csp\Plugin\ReportingHandlerBase`, add the
`@CspReportingHandler` annotation, and place it under
`src/Plugin/CspReportingHandler/`. Refer to the csp module's docs for that plugin type.
