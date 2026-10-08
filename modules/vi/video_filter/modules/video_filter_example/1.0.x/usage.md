Video Filter Example is a demonstration submodule of Video Filter that ships one sample `@VideoFilter` codec plugin showing how to add support for a new provider.

---

The submodule contains no hooks or configuration — just `src/Plugin/VideoFilter/ExampleCodec.php`, a codec with id `example` whose regexp matches `drupal.org/project/<name>` URLs and whose `iframe()` returns a `src` pointing back at the matched Drupal.org project page (aspect ratio `4/3`). It exists purely as copy-paste reference for developers writing their own codec: it demonstrates the annotation (`id`, `name`, `example_url`, `regexp`, `ratio`), reading a regexp capture via `$video['codec']['matches'][1]`, and providing per-video `options()`. Enabling it adds an "Example" entry to the enabled-plugins checkboxes of any format using the Video Filter filter. It relies on the parent `video_filter` module's `VideoFilterBase` and plugin manager. Its `info.yml` declares `core_version_requirement: ^9 || ^10` (no explicit `^11`). Not for production use — enable only to study or test codec development.

---

- Learn the structure of a Video Filter `@VideoFilter` codec plugin by reading a working example.
- Copy `ExampleCodec.php` as a starting template for a real provider codec.
- See how a regexp capture group maps to `$video['codec']['matches'][1]` in `iframe()`.
- Demonstrate per-video `options()` (width/height) on a custom codec.
- Test that a newly added codec appears in a text format's enabled-plugins checkboxes.
- Verify the Video Filter plugin discovery/manager works on your site.
- Use as a teaching aid when onboarding developers to Video Filter's plugin system.
- Confirm `[video:https://www.drupal.org/project/<name>]` renders via the example codec.
- Understand the `@VideoFilter` annotation properties (`id`, `name`, `example_url`, `regexp`, `ratio`).
- See where a codec class lives (`src/Plugin/VideoFilter/`) for plugin discovery.
- Model your own codec's `iframe()` return shape (`['src' => ..., 'properties' => [...]]`).
- Reference how to declare multiple regexp patterns for one provider.
- Demonstrate a codec that returns an empty `html()` (iframe-only provider).
- Provide a minimal example for automated tests of the Video Filter plugin system.
- Show how a codec's aspect `ratio` (`4/3`) feeds player sizing.
- Practice enabling/disabling a specific codec per text format.
- Compare a trivial codec against the full built-in providers (YouTube, Vimeo, etc.).
- Serve as scaffolding to fork into an intranet/self-hosted video provider codec.
- Illustrate that a codec needs no hooks, config, or services — just the plugin class.
