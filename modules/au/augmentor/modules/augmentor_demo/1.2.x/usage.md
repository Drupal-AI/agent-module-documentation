A blueprint Augmentor plugin that splits text into sentences, provided as reference code for developers building their own augmentors.

---

`augmentor_demo` is the example/blueprint submodule of the Augmentor framework. It ships a single Augmentor plugin (`Drupal\augmentor_demo\Plugin\Augmentor\Demo`, id `demo`, label "Demo Augmentor") whose `execute()` method does purely local string processing — it strips tags/punctuation and splits the input on the period character, returning either the first sentence ("Content" mode) or the unique words of the first sentence ("Tags" mode). It performs no external/API calls and needs no API key (its config form removes the parent's `key` field). Enabling this submodule adds a "Demo Augmentor" instance you can create and wire into fields or the CKEditor toolbar to exercise the framework end-to-end without provisioning an AI provider. It also implements `hook_help()` (via `AugmentorDemoHooks`) and is meant to be read as a minimal, copyable template for writing custom augmentor plugins.

---

- Provide a zero-configuration augmentor for testing the Augmentor framework without an AI API key.
- Serve as a copy-paste blueprint for developers writing their own Augmentor plugins.
- Demonstrate the `@Augmentor`/`#[Augmentor]` plugin annotation + attribute and the `AugmentorBase` contract.
- Show how to implement the required `execute($input)` method and return the `['default' => …]` result shape.
- Illustrate customising an augmentor's configuration form (adding an "output format" select, removing the API `key` field).
- Split a block of text into sentences on the period character for demo purposes.
- Return just the first sentence of the input when the "Content" output format is chosen.
- Return the unique words of the first sentence when the "Tags" output format is chosen (useful to demo tag-style widgets).
- Exercise the Augmentor field widgets (default/select/tags) end-to-end with predictable, offline output.
- Test the CKEditor 4/5 augmentor toolbar integration without calling a remote AI service.
- Validate augmentor configuration, permissions and routing on a site before adding real providers.
- Act as a smoke-test augmentor in automated/functional tests of the framework.
- Teach the `hook_help()` pattern via the module's help text on the Augmentor help page.
- Give a safe default augmentor when demoing the module to stakeholders.
- Provide a deterministic augmentor for reproducing framework bugs without provider variability.
