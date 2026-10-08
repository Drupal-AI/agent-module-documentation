# Services: build & run ImageMagick commands

All autowired by interface (see `imagemagick.services.yml`).

## `ImagemagickExecArguments`
Fluent builder for the command line (source, destination, and argument list). Key methods:
- `add(array $args, ArgumentMode $mode = ArgumentMode::PostSource, int $index = APPEND, array $info = [])` — append arguments.
- `find(string $regex, ?ArgumentMode $mode = NULL, array $info = [])`, `remove(int $index)`, `reset()` — inspect/mutate.
- `setSource()/getSource()`, `setSourceLocalPath()/getSourceLocalPath()`,
  `setSourceFormat()/setSourceFormatFromExtension()`, `setSourceFrames()`.
- `setDestination()/getDestination()`, `setDestinationLocalPath()`,
  `setDestinationFormat()/setDestinationFormatFromExtension()`.
- `toArray(ArgumentMode $mode)`, `toDebugString(ArgumentMode $mode)`.

`ArgumentMode` (enum) distinguishes pre-source vs post-source placement of arguments on the
`convert` command line.

## `ImagemagickExecManagerInterface`
Runs the binaries.
- `execute(PackageCommand $command, ImagemagickExecArguments $arguments, string &$output, string &$error, ?string $path = NULL): bool`
- `runProcess(array $command, string $id, string &$output, string &$error): int|bool`
- `checkPath(string $path, ?PackageSuite $package, ?string $version): array` — validate binaries.
- `getPackageSuite()`, `getPackageSuiteVersion()`, `setTimeout(int)`, `getFormatMapper()`.
- `PackageCommand` / `PackageSuite` enums pick `convert`/`identify` vs `gm`.

## `ImagemagickFormatMapperInterface`
Format/MIME/extension mapping (backed by `sophron`):
`getEnabledFormats()`, `getEnabledExtensions()`, `isFormatEnabled($format)`,
`getMimeTypeFromFormat($format)`, `getFormatFromExtension($extension)`, `validateMap($map)`.

Prefer implementing image work as an ImageToolkit operation plugin
([../plugins/operations.md](../plugins/operations.md)); use these services directly for
custom pipelines. To tweak the args of existing operations, use events
([../extend/events.md](../extend/events.md)).
