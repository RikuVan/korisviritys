import 'package:flutter/material.dart';

const supportedLanguageCodes = [
  'en',
  'fi',
  'sv',
  'et',
  'lv',
  'lt',
  'ru',
  'de',
  'es',
  'fr',
  'it',
  'el',
  'tr',
  'sr',
  'hr',
  'sl',
];

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const delegate = _AppLocalizationsDelegate();

  static final supportedLocales = supportedLanguageCodes
      .map((c) => Locale(c))
      .toList();

  static String? getTranslation(String localeCode, String key) =>
      _translations[localeCode]?[key];

  String _t(String key) =>
      _translations[locale.languageCode]?[key] ??
      _translations['en']![key] ??
      key;

  // Controls
  String get timeout => _t('timeout');
  String get chooseTimeoutDuration => _t('chooseTimeoutDuration');
  String get halftime => _t('halftime');
  String get chooseHalftimeDuration => _t('chooseHalftimeDuration');
  String get period => _t('period');
  String get buzzer => _t('buzzer');
  String get or_ => _t('or');
  String get start => _t('start');
  String get min => _t('min');

  // Settings
  String get gameSettings => _t('gameSettings');
  String get homeTeam => _t('homeTeam');
  String get awayTeam => _t('awayTeam');
  String get cancel => _t('cancel');
  String get save => _t('save');
  String get language => _t('language');

  // Timer
  String get minutesLabel => _t('minutesLabel');
  String get secondsLabel => _t('secondsLabel');

  // Scores
  String get possession => _t('possession');

  // Bottom bar
  String get shortcutsHint => _t('shortcutsHint');
  String get undo => _t('undo');
  String get resetGame => _t('resetGame');
  String get settings => _t('settings');

  // Timeout overlay
  String get pressToCancel => _t('pressToCancel');

  // Fouls
  String get fouls => _t('fouls');

  // Reset dialog
  String get resetConfirmation => _t('resetConfirmation');
  String get reset => _t('reset');

  // Default team names
  String get defaultHome => _t('defaultHome');
  String get defaultAway => _t('defaultAway');

  static const _translations = {
    // English
    'en': {
      'timeout': 'TIMEOUT',
      'chooseTimeoutDuration': 'Choose timeout duration:',
      'halftime': 'HALFTIME',
      'chooseHalftimeDuration': 'Choose halftime duration:',
      'period': 'PERIOD',
      'buzzer': 'BUZZER',
      'or': 'or',
      'start': 'START',
      'min': 'min',
      'gameSettings': 'GAME SETTINGS',
      'homeTeam': 'Home team',
      'awayTeam': 'Away team',
      'cancel': 'CANCEL',
      'save': 'SAVE',
      'language': 'Language',
      'minutesLabel': 'MINUTES',
      'secondsLabel': 'SECONDS',
      'possession': 'POSSESSION',
      'shortcutsHint': 'SPACE = clock  |  1/2/3 = home  |  8/9/0 = away',
      'undo': 'UNDO',
      'resetGame': 'RESET GAME',
      'settings': 'SETTINGS',
      'pressToCancel': 'Press to cancel',
      'fouls': 'FOULS',
      'resetConfirmation':
          'Are you sure you want to reset the game? All scores, fouls and clock will be reset.',
      'reset': 'RESET',
      'defaultHome': 'HOME',
      'defaultAway': 'AWAY',
    },
    // Finnish
    'fi': {
      'timeout': 'AIKALIS\u00C4',
      'chooseTimeoutDuration': 'Valitse aikalis\u00E4n pituus:',
      'halftime': 'PUOLIAIKA',
      'chooseHalftimeDuration': 'Valitse puoliajan pituus:',
      'period': 'JAKSO',
      'buzzer': 'SUMMERI',
      'or': 'tai',
      'start': 'ALOITA',
      'min': 'min',
      'gameSettings': 'PELIN ASETUKSET',
      'homeTeam': 'Kotijoukkue',
      'awayTeam': 'Vierasjoukkue',
      'cancel': 'PERUUTA',
      'save': 'TALLENNA',
      'language': 'Kieli',
      'minutesLabel': 'MINUUTIT',
      'secondsLabel': 'SEKUNNIT',
      'possession': 'HALLINTA',
      'shortcutsHint':
          'V\u00C4LILY\u00D6NTI = kello  |  1/2/3 = koti  |  8/9/0 = vieras',
      'undo': 'KUMOA',
      'resetGame': 'NOLLAA PELI',
      'settings': 'ASETUKSET',
      'pressToCancel': 'Paina peruuttaaksesi',
      'fouls': 'VIRHEET',
      'resetConfirmation':
          'Haluatko varmasti nollata pelin? Kaikki pisteet, virheet ja kello palautetaan alkutilaan.',
      'reset': 'NOLLAA',
      'defaultHome': 'KOTI',
      'defaultAway': 'VIERAS',
    },
    // Swedish
    'sv': {
      'timeout': 'TIMEOUT',
      'chooseTimeoutDuration': 'V\u00E4lj timeout-l\u00E4ngd:',
      'halftime': 'HALVTID',
      'chooseHalftimeDuration': 'V\u00E4lj halvtidsl\u00E4ngd:',
      'period': 'PERIOD',
      'buzzer': 'SUMMER',
      'or': 'eller',
      'start': 'STARTA',
      'min': 'min',
      'gameSettings': 'SPELINST\u00C4LLNINGAR',
      'homeTeam': 'Hemmalag',
      'awayTeam': 'Bortalag',
      'cancel': 'AVBRYT',
      'save': 'SPARA',
      'language': 'Spr\u00E5k',
      'minutesLabel': 'MINUTER',
      'secondsLabel': 'SEKUNDER',
      'possession': 'BOLLINNEHAV',
      'shortcutsHint':
          'MELLANSLAG = klocka  |  1/2/3 = hemma  |  8/9/0 = borta',
      'undo': '\u00C5NGRA',
      'resetGame': 'NOLLST\u00C4LL',
      'settings': 'INST\u00C4LLNINGAR',
      'pressToCancel': 'Tryck f\u00F6r att avbryta',
      'fouls': 'FOUL',
      'resetConfirmation':
          'Vill du verkligen nollst\u00E4lla matchen? Alla po\u00E4ng, foul och klockan \u00E5terst\u00E4lls.',
      'reset': 'NOLLST\u00C4LL',
      'defaultHome': 'HEMMA',
      'defaultAway': 'BORTA',
    },
    // Estonian
    'et': {
      'timeout': 'AEG MAHA',
      'chooseTimeoutDuration': 'Vali aeg maha kestus:',
      'halftime': 'POOLAEG',
      'chooseHalftimeDuration': 'Vali poolaja kestus:',
      'period': 'VEERANDAEG',
      'buzzer': 'SIREEN',
      'or': 'v\u00F5i',
      'start': 'ALUSTA',
      'min': 'min',
      'gameSettings': 'M\u00C4NGU SEADED',
      'homeTeam': 'Koduv\u00F5istkond',
      'awayTeam': 'K\u00FClalisv\u00F5istkond',
      'cancel': 'T\u00DCHISTA',
      'save': 'SALVESTA',
      'language': 'Keel',
      'minutesLabel': 'MINUTID',
      'secondsLabel': 'SEKUNDID',
      'possession': 'PALLVALDUS',
      'shortcutsHint':
          'T\u00DCHIK = kell  |  1/2/3 = kodu  |  8/9/0 = k\u00FClalised',
      'undo': 'V\u00D5TA TAGASI',
      'resetGame': 'L\u00C4HTESTA',
      'settings': 'SEADED',
      'pressToCancel': 'Vajuta t\u00FChistamiseks',
      'fouls': 'VEAD',
      'resetConfirmation':
          'Kas oled kindel, et soovid m\u00E4ngu l\u00E4htestada? K\u00F5ik punktid, vead ja aeg l\u00E4htestatakse.',
      'reset': 'L\u00C4HTESTA',
      'defaultHome': 'KODU',
      'defaultAway': 'K\u00DCLALISED',
    },
    // Latvian
    'lv': {
      'timeout': 'P\u0100RTRAUKUMS',
      'chooseTimeoutDuration': 'Izv\u0113lieties p\u0101rtraukuma ilgumu:',
      'halftime': 'PUSLAIKS',
      'chooseHalftimeDuration': 'Izv\u0113lieties puslaika ilgumu:',
      'period': 'CETURTDA\u013CA',
      'buzzer': 'SIR\u0112NA',
      'or': 'vai',
      'start': 'S\u0100KT',
      'min': 'min',
      'gameSettings': 'SP\u0112LES IESTAT\u012AJUMI',
      'homeTeam': 'M\u0101jas komanda',
      'awayTeam': 'Viesu komanda',
      'cancel': 'ATCELT',
      'save': 'SAGLAB\u0100T',
      'language': 'Valoda',
      'minutesLabel': 'MIN\u016ATES',
      'secondsLabel': 'SEKUNDES',
      'possession': 'BUMBA',
      'shortcutsHint':
          'ATSTARPE = pulkstenis  |  1/2/3 = m\u0101jas  |  8/9/0 = viesi',
      'undo': 'ATSAUKT',
      'resetGame': 'ATIESTAT\u012AT',
      'settings': 'IESTAT\u012AJUMI',
      'pressToCancel': 'Nospiediet lai atceltu',
      'fouls': 'P\u0100RK\u0100PUMI',
      'resetConfirmation':
          'Vai tie\u0161\u0101m v\u0113laties atiestat\u012Bt sp\u0113li? Visi punkti, p\u0101rk\u0101pumi un laiks tiks atiestat\u012Bti.',
      'reset': 'ATIESTAT\u012AT',
      'defaultHome': 'M\u0100JAS',
      'defaultAway': 'VIESI',
    },
    // Lithuanian
    'lt': {
      'timeout': 'MINUT\u0116S PERTRAUK\u0116L\u0116',
      'chooseTimeoutDuration':
          'Pasirinkite pertrauk\u0117l\u0117s trukm\u0119:',
      'halftime': 'PERTRAUKA',
      'chooseHalftimeDuration': 'Pasirinkite pertraukos trukm\u0119:',
      'period': 'K\u0116LINYS',
      'buzzer': 'SIRENA',
      'or': 'arba',
      'start': 'PRAD\u0116TI',
      'min': 'min',
      'gameSettings': '\u017DAIDIMO NUSTATYMAI',
      'homeTeam': 'Nam\u0173 komanda',
      'awayTeam': 'Sve\u010Di\u0173 komanda',
      'cancel': 'AT\u0160AUKTI',
      'save': 'I\u0160SAUGOTI',
      'language': 'Kalba',
      'minutesLabel': 'MINUT\u0116S',
      'secondsLabel': 'SEKUND\u0116S',
      'possession': 'KAMUOLIO VALDYMAS',
      'shortcutsHint':
          'TARPAS = laikrodis  |  1/2/3 = namai  |  8/9/0 = sve\u010Diai',
      'undo': 'AT\u0160AUKTI',
      'resetGame': 'ATSTATYTI',
      'settings': 'NUSTATYMAI',
      'pressToCancel': 'Paspauskite nor\u0117dami at\u0161aukti',
      'fouls': 'PRA\u017DANGOS',
      'resetConfirmation':
          'Ar tikrai norite atstatyti \u017Eaidim\u0105? Visi ta\u0161kai, pra\u017Eangos ir laikas bus atstatyti.',
      'reset': 'ATSTATYTI',
      'defaultHome': 'NAMAI',
      'defaultAway': 'SVE\u010CIAI',
    },
    // Russian
    'ru': {
      'timeout': '\u0422\u0410\u0419\u041C-\u0410\u0423\u0422',
      'chooseTimeoutDuration':
          '\u0412\u044B\u0431\u0435\u0440\u0438\u0442\u0435 \u0434\u043B\u0438\u0442\u0435\u043B\u044C\u043D\u043E\u0441\u0442\u044C \u0442\u0430\u0439\u043C-\u0430\u0443\u0442\u0430:',
      'halftime': '\u041F\u0415\u0420\u0415\u0420\u042B\u0412',
      'chooseHalftimeDuration':
          '\u0412\u044B\u0431\u0435\u0440\u0438\u0442\u0435 \u0434\u043B\u0438\u0442\u0435\u043B\u044C\u043D\u043E\u0441\u0442\u044C \u043F\u0435\u0440\u0435\u0440\u044B\u0432\u0430:',
      'period': '\u041F\u0415\u0420\u0418\u041E\u0414',
      'buzzer': '\u0421\u0418\u0413\u041D\u0410\u041B',
      'or': '\u0438\u043B\u0438',
      'start': '\u0421\u0422\u0410\u0420\u0422',
      'min': '\u043C\u0438\u043D',
      'gameSettings':
          '\u041D\u0410\u0421\u0422\u0420\u041E\u0419\u041A\u0418 \u0418\u0413\u0420\u042B',
      'homeTeam':
          '\u0414\u043E\u043C\u0430\u0448\u043D\u044F\u044F \u043A\u043E\u043C\u0430\u043D\u0434\u0430',
      'awayTeam':
          '\u0413\u043E\u0441\u0442\u0435\u0432\u0430\u044F \u043A\u043E\u043C\u0430\u043D\u0434\u0430',
      'cancel': '\u041E\u0422\u041C\u0415\u041D\u0410',
      'save': '\u0421\u041E\u0425\u0420\u0410\u041D\u0418\u0422\u042C',
      'language': '\u042F\u0437\u044B\u043A',
      'minutesLabel': '\u041C\u0418\u041D\u0423\u0422\u042B',
      'secondsLabel': '\u0421\u0415\u041A\u0423\u041D\u0414\u042B',
      'possession': '\u0412\u041B\u0410\u0414\u0415\u041D\u0418\u0415',
      'shortcutsHint':
          '\u041F\u0420\u041E\u0411\u0415\u041B = \u0447\u0430\u0441\u044B  |  1/2/3 = \u0434\u043E\u043C  |  8/9/0 = \u0433\u043E\u0441\u0442\u0438',
      'undo': '\u041E\u0422\u041C\u0415\u041D\u0418\u0422\u042C',
      'resetGame': '\u0421\u0411\u0420\u041E\u0421\u0418\u0422\u042C',
      'settings': '\u041D\u0410\u0421\u0422\u0420\u041E\u0419\u041A\u0418',
      'pressToCancel':
          '\u041D\u0430\u0436\u043C\u0438\u0442\u0435 \u0434\u043B\u044F \u043E\u0442\u043C\u0435\u043D\u044B',
      'fouls': '\u0424\u041E\u041B\u042B',
      'resetConfirmation':
          '\u0412\u044B \u0443\u0432\u0435\u0440\u0435\u043D\u044B, \u0447\u0442\u043E \u0445\u043E\u0442\u0438\u0442\u0435 \u0441\u0431\u0440\u043E\u0441\u0438\u0442\u044C \u0438\u0433\u0440\u0443? \u0412\u0441\u0435 \u043E\u0447\u043A\u0438, \u0444\u043E\u043B\u044B \u0438 \u0432\u0440\u0435\u043C\u044F \u0431\u0443\u0434\u0443\u0442 \u0441\u0431\u0440\u043E\u0448\u0435\u043D\u044B.',
      'reset': '\u0421\u0411\u0420\u041E\u0421',
      'defaultHome': '\u0414\u041E\u041C',
      'defaultAway': '\u0413\u041E\u0421\u0422\u0418',
    },
    // German
    'de': {
      'timeout': 'AUSZEIT',
      'chooseTimeoutDuration': 'Auszeit-Dauer w\u00E4hlen:',
      'halftime': 'HALBZEIT',
      'chooseHalftimeDuration': 'Halbzeitdauer w\u00E4hlen:',
      'period': 'VIERTEL',
      'buzzer': 'SUMMER',
      'or': 'oder',
      'start': 'START',
      'min': 'Min',
      'gameSettings': 'SPIELEINSTELLUNGEN',
      'homeTeam': 'Heimmannschaft',
      'awayTeam': 'Gastmannschaft',
      'cancel': 'ABBRECHEN',
      'save': 'SPEICHERN',
      'language': 'Sprache',
      'minutesLabel': 'MINUTEN',
      'secondsLabel': 'SEKUNDEN',
      'possession': 'BALLBESITZ',
      'shortcutsHint': 'LEERTASTE = Uhr  |  1/2/3 = Heim  |  8/9/0 = Gast',
      'undo': 'R\u00DCCKG\u00C4NGIG',
      'resetGame': 'ZUR\u00DCCKSETZEN',
      'settings': 'EINSTELLUNGEN',
      'pressToCancel': 'Dr\u00FCcken zum Abbrechen',
      'fouls': 'FOULS',
      'resetConfirmation':
          'M\u00F6chten Sie das Spiel wirklich zur\u00FCcksetzen? Alle Punkte, Fouls und die Uhr werden zur\u00FCckgesetzt.',
      'reset': 'ZUR\u00DCCKSETZEN',
      'defaultHome': 'HEIM',
      'defaultAway': 'GAST',
    },
    // Spanish
    'es': {
      'timeout': 'TIEMPO MUERTO',
      'chooseTimeoutDuration': 'Elige la duraci\u00F3n del tiempo muerto:',
      'halftime': 'DESCANSO',
      'chooseHalftimeDuration': 'Elige la duraci\u00F3n del descanso:',
      'period': 'CUARTO',
      'buzzer': 'BOCINA',
      'or': 'o',
      'start': 'INICIAR',
      'min': 'min',
      'gameSettings': 'AJUSTES DEL JUEGO',
      'homeTeam': 'Equipo local',
      'awayTeam': 'Equipo visitante',
      'cancel': 'CANCELAR',
      'save': 'GUARDAR',
      'language': 'Idioma',
      'minutesLabel': 'MINUTOS',
      'secondsLabel': 'SEGUNDOS',
      'possession': 'POSESI\u00D3N',
      'shortcutsHint':
          'ESPACIO = reloj  |  1/2/3 = local  |  8/9/0 = visitante',
      'undo': 'DESHACER',
      'resetGame': 'REINICIAR',
      'settings': 'AJUSTES',
      'pressToCancel': 'Pulsa para cancelar',
      'fouls': 'FALTAS',
      'resetConfirmation':
          '\u00BFEst\u00E1s seguro de que quieres reiniciar el juego? Todos los puntos, faltas y el reloj se reiniciar\u00E1n.',
      'reset': 'REINICIAR',
      'defaultHome': 'LOCAL',
      'defaultAway': 'VISITANTE',
    },
    // French
    'fr': {
      'timeout': 'TEMPS MORT',
      'chooseTimeoutDuration': 'Choisir la dur\u00E9e du temps mort :',
      'halftime': 'MI-TEMPS',
      'chooseHalftimeDuration': 'Choisir la dur\u00E9e de la mi-temps :',
      'period': 'QUART-TEMPS',
      'buzzer': 'BUZZER',
      'or': 'ou',
      'start': 'D\u00C9MARRER',
      'min': 'min',
      'gameSettings': 'PARAM\u00C8TRES DU JEU',
      'homeTeam': '\u00C9quipe domicile',
      'awayTeam': '\u00C9quipe ext\u00E9rieur',
      'cancel': 'ANNULER',
      'save': 'SAUVEGARDER',
      'language': 'Langue',
      'minutesLabel': 'MINUTES',
      'secondsLabel': 'SECONDES',
      'possession': 'POSSESSION',
      'shortcutsHint':
          'ESPACE = horloge  |  1/2/3 = domicile  |  8/9/0 = ext\u00E9rieur',
      'undo': 'ANNULER',
      'resetGame': 'R\u00C9INITIALISER',
      'settings': 'PARAM\u00C8TRES',
      'pressToCancel': 'Appuyer pour annuler',
      'fouls': 'FAUTES',
      'resetConfirmation':
          '\u00CAtes-vous s\u00FBr de vouloir r\u00E9initialiser le match ? Tous les points, fautes et le chrono seront r\u00E9initialis\u00E9s.',
      'reset': 'R\u00C9INITIALISER',
      'defaultHome': 'DOMICILE',
      'defaultAway': 'EXT\u00C9RIEUR',
    },
    // Italian
    'it': {
      'timeout': 'TIME-OUT',
      'chooseTimeoutDuration': "Scegli la durata del time-out:",
      'halftime': 'INTERVALLO',
      'chooseHalftimeDuration': "Scegli la durata dell'intervallo:",
      'period': 'QUARTO',
      'buzzer': 'BUZZER',
      'or': 'o',
      'start': 'AVVIA',
      'min': 'min',
      'gameSettings': 'IMPOSTAZIONI PARTITA',
      'homeTeam': 'Squadra di casa',
      'awayTeam': 'Squadra ospite',
      'cancel': 'ANNULLA',
      'save': 'SALVA',
      'language': 'Lingua',
      'minutesLabel': 'MINUTI',
      'secondsLabel': 'SECONDI',
      'possession': 'POSSESSO',
      'shortcutsHint': 'SPAZIO = orologio  |  1/2/3 = casa  |  8/9/0 = ospite',
      'undo': 'ANNULLA',
      'resetGame': 'AZZERA PARTITA',
      'settings': 'IMPOSTAZIONI',
      'pressToCancel': 'Premi per annullare',
      'fouls': 'FALLI',
      'resetConfirmation':
          'Sei sicuro di voler azzerare la partita? Tutti i punti, i falli e il tempo verranno azzerati.',
      'reset': 'AZZERA',
      'defaultHome': 'CASA',
      'defaultAway': 'OSPITE',
    },
    // Greek
    'el': {
      'timeout': '\u03A4\u0391\u03AA\u039C-\u0391\u039F\u03A5\u03A4',
      'chooseTimeoutDuration':
          '\u0395\u03C0\u03B9\u03BB\u03AD\u03BE\u03C4\u03B5 \u03B4\u03B9\u03AC\u03C1\u03BA\u03B5\u03B9\u03B1 \u03C4\u03AC\u03B9\u03BC-\u03AC\u03BF\u03C5\u03C4:',
      'halftime': '\u0397\u039C\u0399\u03A7\u03A1\u039F\u039D\u039F',
      'chooseHalftimeDuration':
          '\u0395\u03C0\u03B9\u03BB\u03AD\u03BE\u03C4\u03B5 \u03B4\u03B9\u03AC\u03C1\u03BA\u03B5\u03B9\u03B1 \u03B7\u03BC\u03B9\u03C7\u03C1\u03CC\u03BD\u03BF\u03C5:',
      'period': '\u03A0\u0395\u03A1\u0399\u039F\u0394\u039F\u03A3',
      'buzzer': '\u03A3\u0395\u0399\u03A1\u0397\u039D\u0391',
      'or': '\u03AE',
      'start': '\u0395\u039A\u039A\u0399\u039D\u0397\u03A3\u0397',
      'min': '\u03BB\u03B5\u03C0',
      'gameSettings':
          '\u03A1\u03A5\u0398\u039C\u0399\u03A3\u0395\u0399\u03A3 \u0391\u0393\u03A9\u039D\u0391',
      'homeTeam':
          '\u0393\u03B7\u03C0\u03B5\u03B4\u03BF\u03CD\u03C7\u03BF\u03C2',
      'awayTeam':
          '\u03A6\u03B9\u03BB\u03BF\u03BE\u03B5\u03BD\u03BF\u03CD\u03BC\u03B5\u03BD\u03BF\u03C2',
      'cancel': '\u0391\u039A\u03A5\u03A1\u03A9\u03A3\u0397',
      'save': '\u0391\u03A0\u039F\u0398\u0397\u039A\u0395\u03A5\u03A3\u0397',
      'language': '\u0393\u03BB\u03CE\u03C3\u03C3\u03B1',
      'minutesLabel': '\u039B\u0395\u03A0\u03A4\u0391',
      'secondsLabel':
          '\u0394\u0395\u03A5\u03A4\u0395\u03A1\u039F\u039B\u0395\u03A0\u03A4\u0391',
      'possession': '\u039A\u0391\u03A4\u039F\u03A7\u0397',
      'shortcutsHint':
          'SPACE = \u03C1\u03BF\u03BB\u03CC\u03B9  |  1/2/3 = \u03B3\u03B7\u03C0\u03B5\u03B4.  |  8/9/0 = \u03C6\u03B9\u03BB\u03BF\u03BE.',
      'undo': '\u0391\u039D\u0391\u0399\u03A1\u0395\u03A3\u0397',
      'resetGame': '\u0395\u03A0\u0391\u039D\u0391\u03A6\u039F\u03A1\u0391',
      'settings': '\u03A1\u03A5\u0398\u039C\u0399\u03A3\u0395\u0399\u03A3',
      'pressToCancel':
          '\u03A0\u03B1\u03C4\u03AE\u03C3\u03C4\u03B5 \u03B3\u03B9\u03B1 \u03B1\u03BA\u03CD\u03C1\u03C9\u03C3\u03B7',
      'fouls': '\u03A6\u0391\u039F\u03A5\u039B',
      'resetConfirmation':
          '\u0395\u03AF\u03C3\u03C4\u03B5 \u03C3\u03AF\u03B3\u03BF\u03C5\u03C1\u03BF\u03B9 \u03CC\u03C4\u03B9 \u03B8\u03AD\u03BB\u03B5\u03C4\u03B5 \u03BD\u03B1 \u03B5\u03C0\u03B1\u03BD\u03B1\u03C6\u03AD\u03C1\u03B5\u03C4\u03B5 \u03C4\u03BF\u03BD \u03B1\u03B3\u03CE\u03BD\u03B1; \u038C\u03BB\u03BF\u03B9 \u03BF\u03B9 \u03C0\u03CC\u03BD\u03C4\u03BF\u03B9, \u03C4\u03B1 \u03C6\u03AC\u03BF\u03C5\u03BB \u03BA\u03B1\u03B9 \u03C4\u03BF \u03C7\u03C1\u03BF\u03BD\u03CC\u03BC\u03B5\u03C4\u03C1\u03BF \u03B8\u03B1 \u03BC\u03B7\u03B4\u03B5\u03BD\u03B9\u03C3\u03C4\u03BF\u03CD\u03BD.',
      'reset': '\u0395\u03A0\u0391\u039D\u0391\u03A6\u039F\u03A1\u0391',
      'defaultHome': '\u0393\u0397\u03A0\u0395\u0394',
      'defaultAway': '\u03A6\u0399\u039B\u039F\u039E',
    },
    // Turkish
    'tr': {
      'timeout': 'MOLA',
      'chooseTimeoutDuration': 'Mola s\u00FCresini se\u00E7in:',
      'halftime': 'DEVRE ARASI',
      'chooseHalftimeDuration': 'Devre aras\u0131 s\u00FCresini se\u00E7in:',
      'period': 'PER\u0130YOT',
      'buzzer': 'S\u0130REN',
      'or': 'veya',
      'start': 'BA\u015ELAT',
      'min': 'dk',
      'gameSettings': 'MA\u00C7 AYARLARI',
      'homeTeam': 'Ev sahibi tak\u0131m',
      'awayTeam': 'Deplasman tak\u0131m\u0131',
      'cancel': '\u0130PTAL',
      'save': 'KAYDET',
      'language': 'Dil',
      'minutesLabel': 'DAK\u0130KA',
      'secondsLabel': 'SAN\u0130YE',
      'possession': 'TOP KONTROL\u00DC',
      'shortcutsHint':
          'BO\u015ELUK = saat  |  1/2/3 = ev  |  8/9/0 = deplasman',
      'undo': 'GER\u0130 AL',
      'resetGame': 'SIFIRLA',
      'settings': 'AYARLAR',
      'pressToCancel': '\u0130ptal etmek i\u00E7in bas\u0131n',
      'fouls': 'FAULLER',
      'resetConfirmation':
          'Ma\u00E7\u0131 s\u0131f\u0131rlamak istedi\u011Finizden emin misiniz? T\u00FCm puanlar, fauller ve s\u00FCre s\u0131f\u0131rlanacak.',
      'reset': 'SIFIRLA',
      'defaultHome': 'EV',
      'defaultAway': 'DEPLASMAN',
    },
    // Serbian
    'sr': {
      'timeout': '\u0422\u0410\u0408\u041C-\u0410\u0423\u0422',
      'chooseTimeoutDuration':
          '\u0418\u0437\u0430\u0431\u0435\u0440\u0438\u0442\u0435 \u0442\u0440\u0430\u0458\u0430\u045A\u0435 \u0442\u0430\u0458\u043C-\u0430\u0443\u0442\u0430:',
      'halftime': '\u041F\u041E\u041B\u0423\u0412\u0420\u0415\u041C\u0415',
      'chooseHalftimeDuration':
          '\u0418\u0437\u0430\u0431\u0435\u0440\u0438\u0442\u0435 \u0442\u0440\u0430\u0458\u0430\u045A\u0435 \u043F\u043E\u043B\u0443\u0432\u0440\u0435\u043C\u0435\u043D\u0430:',
      'period': '\u0427\u0415\u0422\u0412\u0420\u0422\u0418\u041D\u0410',
      'buzzer': '\u0421\u0418\u0420\u0415\u041D\u0410',
      'or': '\u0438\u043B\u0438',
      'start': '\u041F\u041E\u041A\u0420\u0415\u041D\u0418',
      'min': '\u043C\u0438\u043D',
      'gameSettings':
          '\u041F\u041E\u0414\u0415\u0428\u0410\u0412\u0410\u040A\u0410 \u0423\u0422\u0410\u041A\u041C\u0418\u0426\u0415',
      'homeTeam': '\u0414\u043E\u043C\u0430\u045B\u0438 \u0442\u0438\u043C',
      'awayTeam':
          '\u0413\u043E\u0441\u0442\u0443\u0458\u0443\u045B\u0438 \u0442\u0438\u043C',
      'cancel': '\u041E\u0422\u041A\u0410\u0416\u0418',
      'save': '\u0421\u0410\u0427\u0423\u0412\u0410\u0408',
      'language': '\u0408\u0435\u0437\u0438\u043A',
      'minutesLabel': '\u041C\u0418\u041D\u0423\u0422\u0418',
      'secondsLabel': '\u0421\u0415\u041A\u0423\u041D\u0414\u0415',
      'possession': '\u041F\u041E\u0421\u0415\u0414',
      'shortcutsHint':
          '\u0420\u0410\u0417\u041C\u0410\u041A = \u0441\u0430\u0442  |  1/2/3 = \u0434\u043E\u043C\u0430\u045B\u0438  |  8/9/0 = \u0433\u043E\u0441\u0442\u0438',
      'undo': '\u041F\u041E\u041D\u0418\u0428\u0422\u0418',
      'resetGame': '\u0420\u0415\u0421\u0415\u0422\u0423\u0408',
      'settings':
          '\u041F\u041E\u0414\u0415\u0428\u0410\u0412\u0410\u040A\u0410',
      'pressToCancel':
          '\u041F\u0440\u0438\u0442\u0438\u0441\u043D\u0438\u0442\u0435 \u0437\u0430 \u043E\u0442\u043A\u0430\u0437\u0438\u0432\u0430\u045A\u0435',
      'fouls': '\u0424\u0410\u0423\u041B\u041E\u0412\u0418',
      'resetConfirmation':
          '\u0414\u0430 \u043B\u0438 \u0441\u0442\u0435 \u0441\u0438\u0433\u0443\u0440\u043D\u0438 \u0434\u0430 \u0436\u0435\u043B\u0438\u0442\u0435 \u0440\u0435\u0441\u0435\u0442\u043E\u0432\u0430\u0442\u0438 \u0443\u0442\u0430\u043A\u043C\u0438\u0446\u0443? \u0421\u0432\u0438 \u043F\u043E\u0435\u043D\u0438, \u0444\u0430\u0443\u043B\u043E\u0432\u0438 \u0438 \u0432\u0440\u0435\u043C\u0435 \u045B\u0435 \u0431\u0438\u0442\u0438 \u0440\u0435\u0441\u0435\u0442\u043E\u0432\u0430\u043D\u0438.',
      'reset': '\u0420\u0415\u0421\u0415\u0422\u0423\u0408',
      'defaultHome': '\u0414\u041E\u041C\u0410\u040B\u0418',
      'defaultAway': '\u0413\u041E\u0421\u0422\u0418',
    },
    // Croatian
    'hr': {
      'timeout': 'TIME-OUT',
      'chooseTimeoutDuration': 'Odaberite trajanje time-outa:',
      'halftime': 'POLUVRIJEME',
      'chooseHalftimeDuration': 'Odaberite trajanje poluvremena:',
      'period': '\u010CETVRTINA',
      'buzzer': 'SIRENA',
      'or': 'ili',
      'start': 'POKRENI',
      'min': 'min',
      'gameSettings': 'POSTAVKE UTAKMICE',
      'homeTeam': 'Doma\u0107i tim',
      'awayTeam': 'Gostuju\u0107i tim',
      'cancel': 'ODUSTANI',
      'save': 'SPREMI',
      'language': 'Jezik',
      'minutesLabel': 'MINUTE',
      'secondsLabel': 'SEKUNDE',
      'possession': 'POSJED',
      'shortcutsHint': 'RAZMAK = sat  |  1/2/3 = doma\u0107i  |  8/9/0 = gosti',
      'undo': 'PONI\u0160TI',
      'resetGame': 'RESETIRAJ',
      'settings': 'POSTAVKE',
      'pressToCancel': 'Pritisnite za odustajanje',
      'fouls': 'FAULOVI',
      'resetConfirmation':
          'Jeste li sigurni da \u017Eelite resetirati utakmicu? Svi bodovi, faulovi i vrijeme bit \u0107e resetirani.',
      'reset': 'RESETIRAJ',
      'defaultHome': 'DOMA\u0106I',
      'defaultAway': 'GOSTI',
    },
    // Slovenian
    'sl': {
      'timeout': 'ODMOR',
      'chooseTimeoutDuration': 'Izberite trajanje odmora:',
      'halftime': 'POL\u010CAS',
      'chooseHalftimeDuration': 'Izberite trajanje pol\u010Dasa:',
      'period': '\u010CETRTINA',
      'buzzer': 'SIRENA',
      'or': 'ali',
      'start': 'ZA\u010CNI',
      'min': 'min',
      'gameSettings': 'NASTAVITVE TEKME',
      'homeTeam': 'Doma\u010Da ekipa',
      'awayTeam': 'Gostujo\u010Da ekipa',
      'cancel': 'PREKLI\u010CI',
      'save': 'SHRANI',
      'language': 'Jezik',
      'minutesLabel': 'MINUTE',
      'secondsLabel': 'SEKUNDE',
      'possession': 'POSEST',
      'shortcutsHint':
          'PRESLEDEK = ura  |  1/2/3 = doma\u010Di  |  8/9/0 = gostje',
      'undo': 'RAZVELJAVI',
      'resetGame': 'PONASTAVI',
      'settings': 'NASTAVITVE',
      'pressToCancel': 'Pritisnite za preklic',
      'fouls': 'NAPAKE',
      'resetConfirmation':
          'Ali ste prepri\u010Dani, da \u017Eelite ponastaviti tekmo? Vse to\u010Dke, napake in \u010Das bodo ponastavljeni.',
      'reset': 'PONASTAVI',
      'defaultHome': 'DOMA\u010CI',
      'defaultAway': 'GOSTJE',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
