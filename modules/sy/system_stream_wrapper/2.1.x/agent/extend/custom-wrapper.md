# Adding your own extension-style stream wrapper

The module exposes reusable base classes you can subclass to define additional read-only,
extension-relative schemes.

## Class hierarchy

```
Drupal\Core\StreamWrapper\LocalStream                (core, full local read/write)
  └ LocalReadOnlyStream        (this module: strips all write/delete/rename/mkdir ops)
      └ ExtensionStreamBase     (this module: owner-name + target parsing, getExternalUrl, dirname)
          ├ ModuleStream / ThemeStream / ProfileStream   (resolve via the matching handler)
          └ LibraryStream                                (resolve via bundled LibraryDiscovery)
```

## To add a scheme

1. Subclass `ExtensionStreamBase` (for extension-relative, read-only files) or
   `LocalReadOnlyStream` (for any read-only local path). Implement:
   - `getDirectoryPath()` — return the base directory the URI's target is relative to.
   - `getName()` / `getDescription()` — human labels.
   - Optionally override `getOwnerName()` to validate the owner and throw
     `\InvalidArgumentException` when it does not exist (as `ModuleStream` does).
2. Register it as a tagged service in your `*.services.yml`:

```yaml
services:
  stream_wrapper.myscheme:
    class: Drupal\mymodule\StreamWrapper\MySchemeStream
    tags:
      - { name: stream_wrapper, scheme: myscheme }
```

3. `drush cr`. Your `myscheme://owner/target` URIs now resolve read-only.

Because the write/lock/delete methods live in `LocalReadOnlyStream`, subclasses automatically inherit
the read-only guarantees — you only supply directory resolution. Note stream wrappers are instantiated
by PHP without constructor arguments, so services are fetched lazily via `\Drupal::…` inside the class
(see how `ModuleStream::getModuleHandler()` and `LibraryStream::getDrupalRoot()` do it).
