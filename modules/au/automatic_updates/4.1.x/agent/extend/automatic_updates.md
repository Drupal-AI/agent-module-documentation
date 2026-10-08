# Extend — sandbox managers, validators & StatusChecker

All services are declared in `automatic_updates.services.yml` (autowired, autoconfigured).
Most classes are marked `@internal` — extend the update pipeline by adding **Package Manager
event validators**, not by subclassing these directly.

## Sandbox managers (the update "stage")

Each extends `Drupal\package_manager\SandboxManagerBase`:

| Service | Role | Stage type |
|---|---|---|
| `UpdateSandboxManager` | Attended / push-button core update | `automatic_updates:attended` |
| `ConsoleUpdateSandboxManager` | Unattended update via `auto-update` CLI | — |
| `ExtensionUpdateSandboxManager` | Module/theme update sandbox | — |

They begin → stage → commit a Composer change in a temporary site copy. Commit is done through
`MaintenanceModeAwareCommitter` (puts the site in maintenance mode during the live sync).

## Validators (react to / block updates)

These are event subscribers on Package Manager's lifecycle events; they run for both attended
updates and readiness checks. To add your own pre-update rule, register a service subscribing
to the same Package Manager events (e.g. `PreCreate`, `PreApply`, `StatusCheck`) and add
`ValidationResult`s.

- `VersionPolicyValidator` — composes the `Validator/VersionPolicy/*` rules:
  `ForbidDevSnapshot`, `ForbidDowngrade`, `ForbidMinorUpdates`, `MajorVersionMatch`,
  `StableReleaseInstalled`, `SupportedBranchInstalled`, `TargetSecurityRelease`,
  `TargetVersionInstallable`, `TargetVersionNotPreRelease`, `TargetVersionStable`.
- `RequestedUpdateValidator` — the version actually staged matches what was requested.
- `StagedProjectsValidator` — only expected projects (core) changed in the sandbox.
- `StagedDatabaseUpdateValidator` — blocks/warns when the update brings DB schema updates.
- `ForbidCoreChangesValidator` — forbids unexpected changes to core files.
- `CronFrequencyValidator` — warns when cron runs too infrequently for reliable unattended
  updates.
- `PhpExtensionsValidator` — required PHP extensions are present.
- `WindowsValidator` — flags unsupported Windows scenarios.
- `UpdateReleaseValidator` — the target release exists / is valid.

## Readiness checks — `StatusChecker`

`Drupal\automatic_updates\Validation\StatusChecker` runs the validators outside an update and
caches results (24h TTL). Call it to re-run checks:

```php
/** @var \Drupal\automatic_updates\Validation\StatusChecker $checker */
$checker = \Drupal::service(\Drupal\automatic_updates\Validation\StatusChecker::class);
$results = $checker->run()->getResults();   // ValidationResult[]
```

Results feed `StatusCheckRequirements` (Status report), `AdminStatusCheckMessages` (admin
warnings), and `StatusCheckMailer` (cron email).

## Release selection

`ReleaseChooser` (`Drupal\automatic_updates\ReleaseChooser`) picks the target release —
`getLatestInInstalledMinor()` / `getLatestInNextMinor()` given a sandbox manager — and is what
the update report preprocessing uses to offer supported "Update now" targets.
