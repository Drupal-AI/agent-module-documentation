<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Environment Context exposes the current runtime environment (dev/stage/prod) to Drupal as a Context, cache context and condition, with pluggable event-based detection.

---

Environment Context gives Drupal a notion of the "current environment". A bundled event subscriber detects the active environment from `Settings::get('environment')` (settings.php) or the `DRUPAL_ENVIRONMENT` environment variable, defaulting to `default`. The detected value is published as a Drupal Context (`environment`), an `environment` cache context that varies render caching per environment, a "Current environment" condition plugin for block/layout visibility, and an `environment` typed-data plugin. Detection and the list of known environments are both driven by events, so other modules can override how the environment is detected or register additional environments without patching. Two optional submodules auto-register environments from Config Split and from Environment Indicator entities.

---

Use it to vary site behaviour, visibility and caching by environment. Typical uses:

- Detect the current environment in custom code via `EnvironmentResolverInterface::getCurrentEnvironment()`.
- Configure the environment in `settings.php` with `$settings['environment'] = 'staging';`.
- Configure the environment via the `DRUPAL_ENVIRONMENT` OS/container environment variable.
- Show or hide a block only on specific environments using the "Current environment" visibility condition.
- Negate the condition to hide a block everywhere except selected environments.
- Display a "you are on staging" warning banner only on non-production environments.
- Restrict a Layout Builder section or component to a chosen environment.
- Vary render-cached output correctly per environment by adding `'#cache' => ['contexts' => ['environment']]`.
- Register custom environments (label, color, URL, arbitrary metadata) by subscribing to `AvailableEnvironmentsEvent`.
- Override the default detection logic by subscribing to `EnvironmentDetectionEvent`.
- Read a single environment's metadata via `EnvironmentRegistryInterface::getDefinition($machine_name)`.
- Build a form select of environments with `EnvironmentRegistryInterface::getEnvironmentOptions()`.
- List all known environment machine names via `getAvailableEnvironments()`.
- Validate a value as a known environment using the `environment` typed-data plugin's `isValid()`.
- Gate feature-flag-style behaviour (enable debug tooling only on `dev`).
- Turn off third-party analytics/tracking on non-production environments.
- Send outbound mail only when the environment is `production`.
- Point integrations at sandbox vs. live endpoints based on the environment name.
- Auto-register every Config Split as an available environment (install `environment_context_config_split`).
- Auto-register every Environment Indicator entity as an available environment (install `environment_context_environment_indicator`).
- Drive per-environment content display or theming decisions in custom plugins.
- Expose the environment to context-aware Views or Blocks via the provided Context.
- Provide a consistent environment value across a multi-site or multi-container deployment.
- Coordinate environment naming between Config Split, Environment Indicator and custom code.
