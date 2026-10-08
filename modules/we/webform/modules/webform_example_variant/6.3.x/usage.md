A reference example module demonstrating how to build a custom Webform variant plugin for A/B testing and personalization of a single webform.

---

Webform Variant Example shows how to implement a `@WebformVariant` plugin — the mechanism that lets one webform present different element configurations to different users (A/B tests, audience segments, personalization). Its `ExampleWebformVariant` class implements `defaultConfiguration()`, `buildConfigurationForm()`, and `applyVariant()`, and restricts itself with `isApplicable()` so it only offers itself to webforms whose id starts with `webform_example_variant_`. Two bundled example webforms — an A/B test and a segments demo — show variants in action, and the module ships a config schema and a Twig summary template. When debugging is enabled it surfaces variant processing on screen. It depends only on `webform`. Copy it to scaffold a variant plugin that swaps elements, defaults, or handlers based on your own logic.

---

- Learn the minimum code needed to build a Webform variant plugin.
- Copy as a scaffold for A/B testing a single webform.
- See how `applyVariant()` mutates a webform at build time.
- Study `isApplicable()` to scope a variant to specific webforms.
- Reference `defaultConfiguration()` and `buildConfigurationForm()`.
- Model audience segmentation / personalization of form elements.
- Learn how to provide a `config/schema` for variant settings.
- See the bundled A/B test and segments example webforms.
- Understand how variants swap element defaults and properties.
- Observe variant processing on screen via the debug option.
- Teach the Webform variant API during developer onboarding.
- Provide a known-good variant for QA and manual testing.
- Prototype personalization logic before writing production code.
- Verify variant config saves and reloads correctly.
- Bootstrap a contrib module that adds a variant strategy.
- Render a variant summary via a Twig template.
- Reference for writing tests around a custom variant.
- Explore how a single webform serves multiple experiences.
- Compare variant behavior against handlers and conditional logic.
