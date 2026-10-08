<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request classes & automatic validation

Turn an incoming HTTP request into a typed, validated PHP object that is injected straight into your
controller method.

## Write a request class

Extend `Drupal\api_toolkit\Request\ApiRequestBase` (abstract; implements `ApiRequestInterface` and
`RefinableCacheableDependencyInterface`). Declare **public** properties; add Symfony constraints via PHP
attributes (or `@Assert\…` annotations).

```php
use Drupal\api_toolkit\Request\ApiRequestBase;
use Symfony\Component\Validator\Constraints as Assert;

class CreatePageRequest extends ApiRequestBase {
  #[Assert\NotBlank]
  #[Assert\Length(max: 255)]
  public string $title;          // non-nullable, no default => REQUIRED

  public ?int $limit = 20;       // nullable + default => optional
}
```

`ApiRequestBase::all()` returns `get_object_vars($this)`; `has($key)` checks presence. The base also
exposes `addCacheContext()/removeCacheContext()/addCacheTag()/removeCacheTag()` (needed because
`ObjectNormalizer` writes to the protected cacheability props).

## How properties are filled (`Normalizer\ApiRequestNormalizer::getValues()`)

Values are merged, later sources winning, from: `$request->request->all()` (POST body) → `$request->query->all()`
(query string) → non-internal request attributes (route params; keys starting with `_` skipped). If the
content type is JSON, the decoded body is merged on top (`json_decode(..., JSON_THROW_ON_ERROR)`; a parse
error throws `ApiValidationException` with HTTP 400).

## Type coercion + validation rules (same normalizer, `denormalize()`)

Only properties declared on the request subclass are processed (base-class props skipped via reflection).

- String value map applied first: `''`, `'null'`, `'[]'` → `NULL`; `'true'`→`TRUE`; `'false'`→`FALSE`
  (also applied to one level of array elements).
- Numeric strings cast to `int`/`float` per the property type; `NULL` → `''` for non-nullable `string`,
  → `[]` for `array`.
- **Backed enum** property: a string/int is converted via `::tryFrom()`; on failure an `Enum` constraint
  violation lists the valid cases.
- **Required rule**: a property whose type is non-nullable AND has no default value gets a `NotNull`
  violation if missing/null.
- **Type rule**: scalar type mismatches (int/float/bool/array/string) raise a Symfony `Type` violation;
  union types pass if any member type matches.
- Any violation ⇒ `throw ApiValidationException::create($violations)` (HTTP 400).
- A cache context `url.query_args:<property>` is added per property, then the values are handed to the
  wrapped `ObjectNormalizer` to build the object.

The service is `api_toolkit.normalizer.api_request` (tagged `normalizer`), wrapping
`api_toolkit.normalizer.object` (`ObjectNormalizer`) and `api_toolkit.validator`.

## Injection + the second validation pass (`ArgumentResolver\ApiRequestResolver`)

`ApiToolkitServiceProvider::alter()` unshifts `api_toolkit.argument_resolver.api_request` to the front of
`http_kernel.controller.argument_resolver`'s resolver list (and removes it entirely if the `serializer`
service is absent). For any controller argument type-hinted as an `ApiRequestInterface`, the resolver:

1. denormalizes the request into that class (the coercion/required/type checks above run here);
2. if `shouldValidate($route)` is true, runs `$validator->validate()` (your attribute constraints) and
   throws `ApiValidationException` with HTTP **422** on violations;
3. yields the object into your method.

`shouldValidate()` returns the route option `_api_validation` when set, else the global
`api_toolkit.settings:auto_validate` (default `true`). Validation groups come from the route option
`_api_validation_groups`. So you can also validate manually in the controller
(`$this->validator->validate($request, NULL, ['create', 'Default'])`) — see the examples submodule.

```php
public function post(CreatePageRequest $request): Response {
  // $request is already built + validated (unless disabled for this route).
}
```

## Toggling validation

- Per route: `options: { _api_validation: false }` or `{ _api_validation_groups: [create] }` in routing.yml.
- Globally: `api_toolkit.settings:auto_validate` (see [../config/settings.md](../config/settings.md)).

## Errors

`Exception\ApiValidationException` (extends Symfony `HttpException`) carries a `ConstraintViolationList`
(`getViolations()`), builds a human-readable `message` from the violations for logs, and is rendered as
standardised JSON by the exception subscriber (see [responses.md](responses.md)) on configured route
formats.
