<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maybe provides a small wrapper class (loosely based on the Maybe monad) that lets developers chain method calls, property reads, and array access across nested Drupal entities without risking fatal exceptions — if any step is missing or null, the chain simply yields null.

You wrap a value with `maybe($object)` (or `new Maybe($object)`) and call methods on it as if it were the underlying object; `Maybe::__call()` intercepts each call. If the current value is an array it operates on the first element (`reset()`); if it is an object it invokes the method only when `method_exists()`, otherwise it sets the value to null. It special-cases entities: a `get('field_name')` call first checks `hasField()`, returning null instead of throwing when the field is absent. Helper methods `property('name')` (guarded by `property_exists`), `array($key, ...)` (guarded array/isset traversal, supporting multiple keys for nested arrays), and `return()` (to extract the final value) round out the API.

The module is a pure PHP utility: it declares no routes, permissions, services, hooks, or configuration, and does not touch request data — the "methods" it calls are supplied by the developer's own code, not by user input, so there is no untrusted-input or web-exposed surface. Its primary use is making theme preprocess functions and similar traversal code concise and crash-resistant (e.g. paragraph → media → file → url in a single line).
---
Pure developer utility class — no routes, permissions, services, hooks, or config. Method names come from developer code (chained calls), not user input, so there is no injection/web surface. `->return()` extracts the result; missing methods/fields/array keys yield null instead of an exception. Note: `array()`/`return()` reuse PHP soft-reserved-word method names.
---
- Traverse paragraph → media → file → URL in one line inside a preprocess.
- Safely read a possibly-missing entity field without an `if` ladder.
- Avoid "call to a member function on null" fatals in theme code.
- Get the first referenced entity of a reference field without index errors.
- Access a nested associative array value with guarded `array('key')`.
- Walk nested arrays with `array('key', 0, 'value')` in one call.
- Read an object property safely with `property('name')`.
- Return null (not an exception) when a field doesn't exist on an entity.
- Simplify 21-line/7-`if` traversal into a single readable chain.
- Fetch a media entity's file URL defensively in a Twig preprocess.
- Guard optional configuration or plugin lookups that may return null.
- Chain getters across entity references without loading each manually.
- Extract the final value at the end of a chain with `return()`.
- Handle empty reference fields gracefully (first-item logic built in).
- Use `maybe()` shorthand instead of `new Maybe()` for brevity.
- Reduce boilerplate null checks in custom module business logic.
- Make render-array building resilient to missing related content.
- Prototype entity-traversal quickly without defensive scaffolding.
