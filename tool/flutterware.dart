import 'package:flutterware/plugins.dart';

/// What flutterware shows for this project.
///
/// One app, so one `Pkg('.')` and every tool pointed at it. A monorepo names a
/// `Pkg` per package and hands each tool the subset it applies to; this is the
/// other case, and it is most projects.
const app = Pkg('.');

void main() => Flutterware.configure((fw) {
  // Brewline is a phone app, so its previews open on a phone rather than on
  // the 900 × 700 rectangle an undeclared package gets. The head of the list
  // is the default and the whole list is what the panel offers.
  fw.use(
    Previews(
      packages: [
        .new(
          app,
          directory: 'demo',
          canvases: [
            PreviewCanvas('', devices: [Devices.iphone16, Devices.androidTall]),
          ],
        ),
      ],
    ),
  );

  // The languages every scenario replays in. `test/scenarios/flutter_test_config.dart`
  // says the same thing to `flutter test`; this says it to the studio.
  fw.use(
    Scenarios(
      packages: [
        .new(app, languages: ['en', 'fr']),
      ],
    ),
  );

  // Where the words are — the one thing a run cannot work out for itself.
  fw.use(
    Translations(
      packages: [
        TranslationsPackage(
          app,
          catalogs: [
            TranslationCatalog(name: 'shop', files: 'assets/i18n/*.json'),
          ],
        ),
      ],
    ),
  );

  fw.use(Dependencies(packages: [.new(app)]));
  fw.use(Assets(packages: [.new(app)]));
  fw.use(NativeSplash(packages: [.new(app)]));
  fw.use(LauncherIcon(packages: [.new(app)]));

  fw.use(
    Run(
      packages: [
        .new(
          app,
          entrypoints: [
            Entrypoint(
              'lib/main.dart',
              name: 'Brewline',
              description: 'The coffee shop',
            ),
          ],
        ),
      ],
    ),
  );
});
