class QuestionCompletion {
  const QuestionCompletion({
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  final Map<String, String> options;
  final String correctAnswer;
  final String explanation;
}

const draftQuestionCompletions = <String, QuestionCompletion>{
  // Principes et valeurs de la République
  'pri_002': QuestionCompletion(
    options: {
      'A': 'Le drapeau tricolore',
      'B': 'Le code de la route',
      'C': 'Le passeport',
      'D': 'La baguette',
    },
    correctAnswer: 'A',
    explanation:
        'Le drapeau bleu, blanc, rouge est un symbole officiel de la République française.',
  ),
  'pri_003': QuestionCompletion(
    options: {
      'A': 'Toutes les personnes sont égales devant la loi.',
      'B': 'Tout le monde doit avoir le même métier.',
      'C': 'Seuls les Français ont des droits.',
      'D': 'L’État choisit la religion de chacun.',
    },
    correctAnswer: 'A',
    explanation:
        'L’égalité signifie que la loi s’applique à toutes et à tous sans discrimination.',
  ),
  'pri_004': QuestionCompletion(
    options: {
      'A': 'La devise de la République française',
      'B': 'Le nom du Parlement',
      'C': 'Le drapeau européen',
      'D': 'Le programme du Gouvernement',
    },
    correctAnswer: 'A',
    explanation:
        '« Liberté, égalité, fraternité » est la devise de la République française.',
  ),
  'pri_005': QuestionCompletion(
    options: {
      'A': 'Oui, si ce n’est pas devant un juge.',
      'B': 'Oui, si la personne n’est pas française.',
      'C': 'Non, c’est interdit par la loi.',
      'D': 'Oui, seulement sur internet.',
    },
    correctAnswer: 'C',
    explanation:
        'Les insultes et discriminations envers une personne en raison de sa différence sont interdites.',
  ),
  'pri_006': QuestionCompletion(
    options: {
      'A': 'Oui, tous les métiers peuvent être réservés aux hommes.',
      'B': 'Non, les femmes et les hommes ont accès aux mêmes métiers.',
      'C': 'Oui, sauf dans le privé.',
      'D': 'Oui, si le maire l’autorise.',
    },
    correctAnswer: 'B',
    explanation:
        'En France, les femmes et les hommes ont les mêmes droits pour accéder à un emploi.',
  ),
  'pri_008': QuestionCompletion(
    options: {
      'A': 'Une monarchie',
      'B': 'Une dictature',
      'C': 'Un empire',
      'D': 'Une République',
    },
    correctAnswer: 'D',
    explanation: 'La France est une République.',
  ),
  'pri_009': QuestionCompletion(
    options: {
      'A': 'Marianne',
      'B': 'Le coq',
      'C': 'La tour Eiffel',
      'D': 'Le béret',
    },
    correctAnswer: 'A',
    explanation: 'Marianne représente officiellement la République française.',
  ),
  'pri_010': QuestionCompletion(
    options: {
      'A': 'Sur les bâtiments publics comme les mairies et les écoles',
      'B': 'Seulement sur les billets en euro',
      'C': 'Uniquement dans les musées',
      'D': 'Seulement sur les passeports',
    },
    correctAnswer: 'A',
    explanation:
        'La devise de la République est souvent affichée sur les bâtiments publics.',
  ),
  'pri_011': QuestionCompletion(
    options: {
      'A': 'Le drapeau tricolore, Marianne et la Marseillaise',
      'B': 'Le Louvre, le métro et la baguette',
      'C': 'Le Sénat, la police et la justice',
      'D': 'Le rugby, le cinéma et la mode',
    },
    correctAnswer: 'A',
    explanation:
        'Le drapeau, Marianne et la Marseillaise font partie des symboles officiels de la République.',
  ),
  'pri_012': QuestionCompletion(
    options: {
      'A': 'Le fait que tout le monde pense la même chose',
      'B': 'Le fait que certaines personnes aient plus de droits',
      'C': 'Le fait que tous aient les mêmes droits et devoirs',
      'D': 'Le fait de vivre dans la même ville',
    },
    correctAnswer: 'C',
    explanation:
        'L’égalité signifie que toutes les personnes ont les mêmes droits et devoirs devant la loi.',
  ),
  'pri_013': QuestionCompletion(
    options: {
      'A': 'Faire tout ce que l’on veut sans limite',
      'B': 'Pouvoir agir et s’exprimer dans le respect de la loi',
      'C': 'Ne jamais avoir de devoirs',
      'D': 'Refuser d’obéir aux règles communes',
    },
    correctAnswer: 'B',
    explanation:
        'La liberté permet de penser, croire et agir, dans le respect de la loi et des autres.',
  ),
  'pri_014': QuestionCompletion(
    options: {
      'A': 'La compétition entre les citoyens',
      'B': 'La solidarité et l’entraide entre les personnes',
      'C': 'L’obligation d’avoir la même religion',
      'D': 'Le fait d’avoir le même salaire',
    },
    correctAnswer: 'B',
    explanation:
        'La fraternité invite à la solidarité, au respect et à l’entraide.',
  ),
  'pri_015': QuestionCompletion(
    options: {
      'A': 'Le coq',
      'B': 'Le lion',
      'C': 'Le taureau',
      'D': 'L’aigle',
    },
    correctAnswer: 'A',
    explanation: 'Le coq est un symbole traditionnel de la France.',
  ),
  'pri_016': QuestionCompletion(
    options: {
      'A': 'Interdire les élections',
      'B': 'Créer du lien social et défendre des causes',
      'C': 'Remplacer les tribunaux',
      'D': 'Écrire les lois à la place du Parlement',
    },
    correctAnswer: 'B',
    explanation:
        'Les associations peuvent aider les personnes, défendre une cause et renforcer le lien social.',
  ),
  'pri_018': QuestionCompletion(
    options: {
      'A': 'Le drapeau français',
      'B': 'Le palais de l’Élysée',
      'C': 'Le Sénat',
      'D': 'Le coq gaulois',
    },
    correctAnswer: 'A',
    explanation:
        'Le drapeau de la République française est bleu, blanc, rouge.',
  ),
  'pri_019': QuestionCompletion(
    options: {
      'A': 'Le 1er mai',
      'B': 'Le 8 mai',
      'C': 'Le 14 juillet',
      'D': 'Le 11 novembre',
    },
    correctAnswer: 'C',
    explanation: 'La fête nationale française a lieu le 14 juillet.',
  ),
  'pri_022': QuestionCompletion(
    options: {
      'A': 'Le français est la langue de la République.',
      'B': 'Chaque région choisit sa langue officielle.',
      'C': 'L’anglais est la langue administrative de l’État.',
      'D': 'La République n’a pas de langue officielle.',
    },
    correctAnswer: 'A',
    explanation:
        'La Constitution précise que le français est la langue de la République.',
  ),
  'pri_023': QuestionCompletion(
    options: {
      'A': 'La liberté de circulation',
      'B': 'La liberté d’expression',
      'C': 'La liberté de commerce',
      'D': 'La liberté de propriété',
    },
    correctAnswer: 'B',
    explanation:
        'La liberté d’expression permet à chacun d’exprimer ses idées dans le respect de la loi.',
  ),
  'pri_024': QuestionCompletion(
    options: {
      'A': 'Permet tout, même les insultes et la haine',
      'B': 'S’exerce dans le respect de la loi',
      'C': 'Est réservée aux journalistes',
      'D': 'N’existe que pendant les élections',
    },
    correctAnswer: 'B',
    explanation:
        'La liberté d’expression est protégée, mais elle a des limites fixées par la loi.',
  ),
  'pri_027': QuestionCompletion(
    options: {
      'A': 'Un défilé militaire',
      'B': 'Une élection présidentielle',
      'C': 'Une rentrée scolaire',
      'D': 'Une réunion du Sénat',
    },
    correctAnswer: 'A',
    explanation:
        'Le 14 juillet, un défilé militaire est traditionnellement organisé sur les Champs-Élysées.',
  ),
  'pri_029': QuestionCompletion(
    options: {
      'A': 'Oui, librement',
      'B': 'Oui, mais seulement avant 18 ans',
      'C': 'Non, jamais',
      'D': 'Non, sauf avec l’accord du préfet',
    },
    correctAnswer: 'A',
    explanation:
        'La liberté de conscience permet de changer de religion ou de ne pas en avoir.',
  ),
  'pri_030': QuestionCompletion(
    options: {
      'A': 'royale',
      'B': 'laïque',
      'C': 'militaire',
      'D': 'religieuse',
    },
    correctAnswer: 'B',
    explanation:
        'L’article 1er de la Constitution dit que la France est une République indivisible, laïque, démocratique et sociale.',
  ),
  'pri_032': QuestionCompletion(
    options: {
      'A': 'D’imposer une religion officielle',
      'B': 'De fermer les lieux de culte',
      'C': 'De garantir la liberté de croire ou de ne pas croire',
      'D': 'D’interdire toute pratique religieuse',
    },
    correctAnswer: 'C',
    explanation:
        'La laïcité protège la liberté de conscience et permet à chacun de croire ou non.',
  ),
  'pri_033': QuestionCompletion(
    options: {
      'A': 'La liberté de conscience',
      'B': 'Le droit de porter une arme',
      'C': 'Le droit de ne jamais voter',
      'D': 'Le droit de ne pas payer d’impôts',
    },
    correctAnswer: 'A',
    explanation:
        'La laïcité garantit la liberté de conscience, donc de croire ou de ne pas croire.',
  ),
  'pri_034': QuestionCompletion(
    options: {
      'A':
          'Pour garantir la neutralité de l’école publique et le respect de tous',
      'B': 'Pour interdire toute opinion personnelle',
      'C': 'Pour réserver l’école à une seule religion',
      'D': 'Pour supprimer les cours d’histoire',
    },
    correctAnswer: 'A',
    explanation:
        'À l’école publique, la laïcité protège la liberté de conscience et le vivre-ensemble.',
  ),
  'pri_035': QuestionCompletion(
    options: {
      'A': 'La séparation des religions et de l’État',
      'B': 'L’interdiction de toutes les religions',
      'C': 'L’obligation de choisir une religion',
      'D': 'Le pouvoir des religions sur l’État',
    },
    correctAnswer: 'A',
    explanation:
        'La laïcité repose sur la neutralité de l’État et la liberté de conscience.',
  ),
  'pri_036': QuestionCompletion(
    options: {
      'A': 'Oui, si sa famille est croyante',
      'B': 'Oui, le choix religieux passe avant tout',
      'C': 'Non, l’école est obligatoire',
      'D': 'Non, sauf avec un certificat du maire',
    },
    correctAnswer: 'C',
    explanation:
        'L’instruction est obligatoire et ne peut pas être refusée pour un motif religieux.',
  ),
  'pri_037': QuestionCompletion(
    options: {
      'A': 'Oui, la liberté de conscience le permet',
      'B': 'Oui, mais seulement à partir de 21 ans',
      'C': 'Non, chacun doit avoir une religion',
      'D': 'Non, sauf autorisation de la mairie',
    },
    correctAnswer: 'A',
    explanation:
        'En France, chacun a le droit de croire, de changer de religion ou de ne pas croire.',
  ),

  // Système institutionnel et politique
  'sys_003': QuestionCompletion(
    options: {
      'A': 'Qui vote les lois',
      'B': 'Qui juge les infractions',
      'C': 'Qui exécute les lois et dirige le Gouvernement',
      'D': 'Qui modifie la Constitution seul',
    },
    correctAnswer: 'C',
    explanation:
        'Le pouvoir exécutif applique les lois et conduit la politique de la Nation.',
  ),
  'sys_004': QuestionCompletion(
    options: {
      'A': 'Une démocratie',
      'B': 'Une dictature',
      'C': 'Une monarchie absolue',
      'D': 'Un régime militaire',
    },
    correctAnswer: 'A',
    explanation:
        'Dans une démocratie, les citoyens élisent leurs représentants.',
  ),
  'sys_005': QuestionCompletion(
    options: {
      'A': 'Oui, si on n’est pas d’accord',
      'B': 'Oui, si la loi paraît ancienne',
      'C': 'Non',
      'D': 'Oui, sauf pendant les élections',
    },
    correctAnswer: 'C',
    explanation:
        'En France, la loi s’impose à toutes les personnes et doit être respectée.',
  ),
  'sys_006': QuestionCompletion(
    options: {
      'A': 'Seulement les citoyens français',
      'B': 'Seulement les ministres',
      'C': 'Tout le monde',
      'D': 'Seulement les juges',
    },
    correctAnswer: 'C',
    explanation: 'Toutes les personnes doivent respecter la loi.',
  ),
  'sys_007': QuestionCompletion(
    options: {
      'A': 'Créer les lois',
      'B': 'Juger et faire respecter la loi',
      'C': 'Nommer les députés',
      'D': 'Diriger les communes',
    },
    correctAnswer: 'B',
    explanation:
        'L’autorité judiciaire rend la justice et veille à l’application de la loi.',
  ),
  'sys_008': QuestionCompletion(
    options: {
      'A': 'Le pouvoir exécutif',
      'B': 'Le pouvoir religieux',
      'C': 'Le pouvoir judiciaire',
      'D': 'Le pouvoir budgétaire',
    },
    correctAnswer: 'C',
    explanation: 'Un juge exerce le pouvoir judiciaire.',
  ),
  'sys_009': QuestionCompletion(
    options: {
      'A': 'Les juges',
      'B': 'Les ministres',
      'C': 'Les maires',
      'D': 'Les préfets',
    },
    correctAnswer: 'A',
    explanation:
        'L’autorité judiciaire est exercée par les magistrats et les juges.',
  ),
  'sys_010': QuestionCompletion(
    options: {
      'A': 'Rien, car il est ministre',
      'B': 'Il peut être jugé et sanctionné',
      'C': 'Il choisit lui-même sa sanction',
      'D': 'Seul le président peut le punir en privé',
    },
    correctAnswer: 'B',
    explanation:
        'Un ministre doit respecter la loi comme toute autre personne.',
  ),
  'sys_011': QuestionCompletion(
    options: {
      'A': 'Les sénateurs',
      'B': 'Les maires',
      'C': 'Les députés',
      'D': 'Les préfets',
    },
    correctAnswer: 'C',
    explanation: 'Les élections législatives servent à élire les députés.',
  ),
  'sys_013': QuestionCompletion(
    options: {
      'A': 'Tous les ans',
      'B': 'Tous les 3 ans pour renouveler la moitié du Sénat',
      'C': 'Tous les 5 ans',
      'D': 'Tous les 10 ans',
    },
    correctAnswer: 'B',
    explanation:
        'Les sénateurs sont élus pour 6 ans, avec un renouvellement de la moitié du Sénat tous les 3 ans.',
  ),
  'sys_014': QuestionCompletion(
    options: {
      'A': 'Les députés',
      'B': 'Les conseillers municipaux',
      'C': 'Les préfets',
      'D': 'Les sénateurs',
    },
    correctAnswer: 'B',
    explanation:
        'Lors des élections municipales, les électeurs choisissent les conseillers municipaux.',
  ),
  'sys_015': QuestionCompletion(
    options: {
      'A': 'Le président de la République',
      'B': 'Le Premier ministre',
      'C': 'Le président du Sénat',
      'D': 'Le maire de Paris',
    },
    correctAnswer: 'A',
    explanation:
        'L’élection présidentielle sert à élire le président de la République.',
  ),
  'sys_020': QuestionCompletion(
    options: {
      'A': 'Le Parlement',
      'B': 'Le président de la République et le Gouvernement',
      'C': 'Les juges',
      'D': 'Les préfets et les maires',
    },
    correctAnswer: 'B',
    explanation:
        'En France, le pouvoir exécutif est exercé par le président de la République et le Gouvernement.',
  ),
  'sys_021': QuestionCompletion(
    options: {
      'A': 'Être inscrit sur les listes électorales',
      'B': 'Être propriétaire de son logement',
      'C': 'Payer des impôts',
      'D': 'Être marié',
    },
    correctAnswer: 'A',
    explanation:
        'Pour voter, il faut notamment être inscrit sur les listes électorales.',
  ),
  'sys_022': QuestionCompletion(
    options: {
      'A': 'Toutes les personnes vivant en France',
      'B': 'Les citoyens français majeurs inscrits sur les listes électorales',
      'C': 'Seulement les élus',
      'D': 'Uniquement les fonctionnaires',
    },
    correctAnswer: 'B',
    explanation:
        'En règle générale, les citoyens français majeurs inscrits peuvent voter aux élections en France.',
  ),
  'sys_023': QuestionCompletion(
    options: {
      'A': 'Le vote réservé aux personnes riches',
      'B': 'Le vote obligatoire à chaque élection',
      'C': 'Le droit de vote pour tous les citoyens majeurs',
      'D': 'Le vote réservé aux élus',
    },
    correctAnswer: 'C',
    explanation:
        'Le suffrage universel signifie que tous les citoyens majeurs ont le droit de vote selon la loi.',
  ),
  'sys_024': QuestionCompletion(
    options: {
      'A': 'Ils sont interdits en France.',
      'B': 'Ils participent à l’expression du suffrage.',
      'C': 'Ils remplacent le Parlement.',
      'D': 'Ils rendent la justice.',
    },
    correctAnswer: 'B',
    explanation:
        'Les partis politiques participent à la vie démocratique et à l’expression du suffrage.',
  ),
  'sys_025': QuestionCompletion(
    options: {
      'A': 'Voter les lois et contrôler le Gouvernement',
      'B': 'Diriger les tribunaux',
      'C': 'Nommer les préfets',
      'D': 'Commander l’armée',
    },
    correctAnswer: 'A',
    explanation:
        'Les députés votent les lois et contrôlent l’action du Gouvernement.',
  ),
  'sys_026': QuestionCompletion(
    options: {
      'A': 'Le pouvoir local, européen et militaire',
      'B': 'Le pouvoir présidentiel, syndical et religieux',
      'C': 'Le pouvoir exécutif, législatif et judiciaire',
      'D': 'Le pouvoir communal, départemental et régional',
    },
    correctAnswer: 'C',
    explanation:
        'La séparation des pouvoirs distingue l’exécutif, le législatif et le judiciaire.',
  ),
  'sys_027': QuestionCompletion(
    options: {
      'A': 'Le Parlement',
      'B': 'Le président de la République',
      'C': 'Le Conseil constitutionnel',
      'D': 'La police',
    },
    correctAnswer: 'A',
    explanation: 'Le pouvoir législatif appartient au Parlement.',
  ),
  'sys_028': QuestionCompletion(
    options: {
      'A': 'Le maire',
      'B': 'Le juge',
      'C': 'Le député',
      'D': 'Le préfet',
    },
    correctAnswer: 'B',
    explanation:
        'C’est la justice, donc le juge, qui sanctionne l’auteur d’un vol.',
  ),
  'sys_029': QuestionCompletion(
    options: {
      'A': 'Les citoyens',
      'B': 'Les sénateurs',
      'C': 'Les juges',
      'D': 'Les préfets',
    },
    correctAnswer: 'A',
    explanation:
        'Les députés sont élus par les citoyens lors des élections législatives.',
  ),
  'sys_030': QuestionCompletion(
    options: {
      'A': 'Le Parlement',
      'B': 'Le Conseil d’État',
      'C': 'La police',
      'D': 'Le maire',
    },
    correctAnswer: 'A',
    explanation: 'Les lois sont votées par le Parlement.',
  ),
  'sys_031': QuestionCompletion(
    options: {
      'A': 'Le Premier ministre',
      'B': 'Le président de la République',
      'C': 'Le président de l’Assemblée nationale',
      'D': 'Le ministre de l’Intérieur',
    },
    correctAnswer: 'B',
    explanation:
        'Le palais de l’Élysée est la résidence officielle du président de la République.',
  ),
  'sys_033': QuestionCompletion(
    options: {
      'A': 'Le préfet',
      'B': 'Le maire',
      'C': 'Le député',
      'D': 'Le sénateur',
    },
    correctAnswer: 'A',
    explanation: 'Dans un département, le préfet représente l’État.',
  ),
  'sys_034': QuestionCompletion(
    options: {
      'A': 'Le préfet',
      'B': 'Le député',
      'C': 'Le maire',
      'D': 'Le ministre de l’Intérieur',
    },
    correctAnswer: 'C',
    explanation: 'Le maire dirige la commune avec le conseil municipal.',
  ),
  'sys_035': QuestionCompletion(
    options: {
      'A': 'Oui, il décide de tout seul',
      'B': 'Oui, sauf pendant les élections',
      'C': 'Non, ses pouvoirs sont limités par la Constitution',
      'D': 'Non, car seuls les juges gouvernent',
    },
    correctAnswer: 'C',
    explanation:
        'Le président n’a pas tous les pouvoirs : la Constitution organise la séparation des pouvoirs.',
  ),
  'sys_036': QuestionCompletion(
    options: {
      'A': 'Le représentant de l’État dans le département',
      'B': 'Le chef du Parlement',
      'C': 'Le chef de la justice',
      'D': 'Le dirigeant d’une commune',
    },
    correctAnswer: 'A',
    explanation:
        'Le préfet représente l’État dans le département et veille à l’application des lois.',
  ),
  'sys_037': QuestionCompletion(
    options: {
      'A': 'Voter la loi et contrôler le Gouvernement',
      'B': 'Rendre la justice',
      'C': 'Diriger les écoles',
      'D': 'Fixer seul les impôts locaux',
    },
    correctAnswer: 'A',
    explanation:
        'Le Parlement vote les lois et contrôle l’action du Gouvernement.',
  ),
  'sys_038': QuestionCompletion(
    options: {
      'A': 'Une monarchie',
      'B': 'Une République démocratique',
      'C': 'Un empire',
      'D': 'Une théocratie',
    },
    correctAnswer: 'B',
    explanation: 'La France est aujourd’hui une République démocratique.',
  ),
  'sys_040': QuestionCompletion(
    options: {
      'A': 'L’Espagne',
      'B': 'La Pologne',
      'C': 'La Suisse',
      'D': 'La France',
    },
    correctAnswer: 'C',
    explanation: 'La Suisse ne fait pas partie de l’Union européenne.',
  ),
  'sys_041': QuestionCompletion(
    options: {
      'A': 'Être citoyen d’un pays de l’Union européenne et être inscrit',
      'B': 'Habiter en France depuis 20 ans',
      'C': 'Avoir un contrat de travail',
      'D': 'Être marié à un Français',
    },
    correctAnswer: 'A',
    explanation:
        'Pour voter aux élections européennes, il faut être citoyen de l’Union européenne et remplir les conditions d’inscription.',
  ),
  'sys_042': QuestionCompletion(
    options: {
      'A': 'Tous les 2 ans',
      'B': 'Tous les 3 ans',
      'C': 'Tous les 5 ans',
      'D': 'Tous les 7 ans',
    },
    correctAnswer: 'C',
    explanation: 'Les élections européennes ont lieu tous les 5 ans.',
  ),
  'sys_043': QuestionCompletion(
    options: {
      'A': 'La France',
      'B': 'La Norvège',
      'C': 'La Suisse',
      'D': 'Le Royaume-Uni',
    },
    correctAnswer: 'A',
    explanation:
        'La France fait partie des pays fondateurs de la construction européenne.',
  ),
  'sys_045': QuestionCompletion(
    options: {
      'A': 'Les citoyens lors des élections européennes',
      'B': 'Le président de la République',
      'C': 'Les préfets',
      'D': 'Les sénateurs',
    },
    correctAnswer: 'A',
    explanation:
        'Les députés européens sont élus par les citoyens lors des élections européennes.',
  ),

  // Droits et devoirs
  'dro_001': QuestionCompletion(
    options: {
      'A': 'La Constitution de la Ve République',
      'B': 'La Charte de 1905',
      'C': 'Le Code civil',
      'D': 'Le règlement du Sénat',
    },
    correctAnswer: 'A',
    explanation:
        'La Constitution actuelle de la France est celle de la Ve République, adoptée en 1958.',
  ),
  'dro_002': QuestionCompletion(
    options: {
      'A': 'La Déclaration des droits de l’homme et du citoyen',
      'B': 'Le Code de la route',
      'C': 'Le règlement intérieur de l’Assemblée nationale',
      'D': 'Le traité de Rome',
    },
    correctAnswer: 'A',
    explanation:
        'La Déclaration de 1789 est un texte fondamental pour les droits et les devoirs en France.',
  ),
  'dro_003': QuestionCompletion(
    options: {
      'A': 'Ils sont réservés aux plus riches.',
      'B': 'Ils dépendent de l’origine des personnes.',
      'C': 'Ils sont garantis et protégés par la loi.',
      'D': 'Ils peuvent être retirés sans raison.',
    },
    correctAnswer: 'C',
    explanation:
        'Les droits individuels sont protégés par la loi et s’appliquent sans discrimination.',
  ),
  'dro_005': QuestionCompletion(
    options: {
      'A': 'La liberté d’expression',
      'B': 'Le droit de frauder',
      'C': 'Le droit d’insulter',
      'D': 'Le droit de voler',
    },
    correctAnswer: 'A',
    explanation: 'La liberté d’expression fait partie des droits fondamentaux.',
  ),
  'dro_006': QuestionCompletion(
    options: {
      'A': 'La Constitution',
      'B': 'Le règlement de copropriété',
      'C': 'Le livret scolaire',
      'D': 'Le permis de conduire',
    },
    correctAnswer: 'A',
    explanation:
        'La Constitution garantit les droits et libertés fondamentaux en France.',
  ),
  'dro_007': QuestionCompletion(
    options: {
      'A': 'Le droit de dire ce que l’on veut sans aucune limite',
      'B': 'Le droit d’exprimer ses idées dans le respect de la loi',
      'C': 'Le droit de parler uniquement en privé',
      'D': 'Le droit réservé aux journalistes',
    },
    correctAnswer: 'B',
    explanation:
        'La liberté d’expression permet d’exprimer ses idées, avec des limites prévues par la loi.',
  ),
  'dro_008': QuestionCompletion(
    options: {
      'A': 'Le droit à la défense',
      'B': 'Le droit de ne jamais comparaître',
      'C': 'Le droit d’être juge',
      'D': 'Le droit de choisir sa peine',
    },
    correctAnswer: 'A',
    explanation:
        'Le droit à la défense permet à une personne de se défendre devant la justice.',
  ),
  'dro_009': QuestionCompletion(
    options: {
      'A': 'La Déclaration des droits de l’homme et du citoyen',
      'B': 'Le Code de commerce',
      'C': 'La Charte de l’ONU',
      'D': 'Le Code de la route',
    },
    correctAnswer: 'A',
    explanation:
        'La Déclaration de 1789 est le texte fondateur des droits et devoirs du citoyen en France.',
  ),
  'dro_010': QuestionCompletion(
    options: {
      'A': 'La Déclaration des droits de l’homme et du citoyen',
      'B': 'Le traité de Maastricht',
      'C': 'La Constitution de 1958',
      'D': 'Le Code civil',
    },
    correctAnswer: 'A',
    explanation:
        'La Déclaration des droits de l’homme et du citoyen a été adoptée pendant la Révolution française.',
  ),
  'dro_011': QuestionCompletion(
    options: {
      'A': 'La liberté de conscience',
      'B': 'La liberté de commerce',
      'C': 'La liberté de circulation',
      'D': 'Le droit de grève',
    },
    correctAnswer: 'A',
    explanation:
        'La liberté de conscience permet de croire, de changer de religion ou de ne pas en avoir.',
  ),
  'dro_012': QuestionCompletion(
    options: {
      'A': 'Seulement avec l’accord de son mari',
      'B': 'Conformément à la loi',
      'C': 'Jamais en France',
      'D': 'Seulement à l’étranger',
    },
    correctAnswer: 'B',
    explanation:
        'En France, l’avortement est autorisé dans le cadre prévu par la loi.',
  ),
  'dro_013': QuestionCompletion(
    options: {
      'A': 'Non, jamais',
      'B': 'Oui',
      'C': 'Oui, seulement si le maire accepte',
      'D': 'Oui, mais seulement pour les couples sans enfants',
    },
    correctAnswer: 'B',
    explanation: 'Le divorce est possible en France selon la loi.',
  ),
  'dro_015': QuestionCompletion(
    options: {
      'A': 'Elles n’ont aucune limite.',
      'B':
          'Elles peuvent être limitées par la loi pour protéger l’ordre public et les autres.',
      'C': 'Seul le maire peut les supprimer.',
      'D': 'Elles concernent seulement les Français.',
    },
    correctAnswer: 'B',
    explanation:
        'Les libertés individuelles existent, mais elles peuvent être encadrées pour protéger l’intérêt général.',
  ),
  'dro_017': QuestionCompletion(
    options: {
      'A': 'Oui',
      'B': 'Non, cela ne sert à rien',
      'C': 'Seulement en été',
      'D': 'Seulement dans les grandes villes',
    },
    correctAnswer: 'A',
    explanation: 'Réduire ses déchets aide à protéger l’environnement.',
  ),
  'dro_018': QuestionCompletion(
    options: {
      'A': 'Un geste autorisé',
      'B': 'Une infraction passible d’une amende',
      'C': 'Une obligation',
      'D': 'Un acte sans conséquence',
    },
    correctAnswer: 'B',
    explanation:
        'Jeter une bouteille dans la rue est interdit et peut être sanctionné.',
  ),
  'dro_019': QuestionCompletion(
    options: {
      'A': 'Pour protéger l’ordre public et les droits des autres',
      'B': 'Pour supprimer la démocratie',
      'C': 'Pour empêcher tout débat',
      'D': 'Pour favoriser une seule religion',
    },
    correctAnswer: 'A',
    explanation:
        'Les libertés peuvent être limitées pour protéger la sécurité, l’ordre public et les droits d’autrui.',
  ),
  'dro_020': QuestionCompletion(
    options: {
      'A': 'Partir sans rien dire',
      'B': 'Appeler ou faire appeler les secours et porter assistance',
      'C': 'Filmer la scène seulement',
      'D': 'Attendre la police chez soi',
    },
    correctAnswer: 'B',
    explanation:
        'En cas d’accident, il faut aider et prévenir les secours rapidement.',
  ),
  'dro_021': QuestionCompletion(
    options: {
      'A': 'De participer à la vie démocratique, notamment en votant',
      'B': 'De ne jamais respecter la loi',
      'C': 'D’éviter les impôts',
      'D': 'De juger les infractions',
    },
    correctAnswer: 'A',
    explanation:
        'La citoyenneté française permet notamment de voter et de participer à la vie publique.',
  ),
  'dro_022': QuestionCompletion(
    options: {
      'A': 'Aucun risque',
      'B': 'Une récompense',
      'C': 'Une sanction',
      'D': 'Un changement automatique de nationalité',
    },
    correctAnswer: 'C',
    explanation: 'Le non-respect de la loi peut entraîner des sanctions.',
  ),
  'dro_023': QuestionCompletion(
    options: {
      'A': 'Assurer la sécurité et faire respecter la loi',
      'B': 'Voter les lois',
      'C': 'Rendre la justice',
      'D': 'Diriger les écoles',
    },
    correctAnswer: 'A',
    explanation:
        'La gendarmerie protège les personnes et veille au respect de la loi.',
  ),
  'dro_024': QuestionCompletion(
    options: {
      'A': 'Assurer la sécurité et faire respecter la loi',
      'B': 'Rédiger la Constitution',
      'C': 'Choisir les juges',
      'D': 'Fixer les salaires',
    },
    correctAnswer: 'A',
    explanation:
        'La police protège les personnes, maintient l’ordre et lutte contre les infractions.',
  ),
  'dro_025': QuestionCompletion(
    options: {
      'A': 'Un acte autorisé par la loi',
      'B': 'Un acte interdit et puni par la loi',
      'C': 'Une décision prise par un juge',
      'D': 'Un simple désaccord entre voisins',
    },
    correctAnswer: 'B',
    explanation: 'Une infraction est un acte contraire à la loi.',
  ),
  'dro_026': QuestionCompletion(
    options: {
      'A': 'En jetant tout dans la rue',
      'B': 'En triant, réutilisant et recyclant',
      'C': 'En brûlant ses déchets',
      'D': 'En laissant ses déchets dehors',
    },
    correctAnswer: 'B',
    explanation:
        'On réduit ses déchets en triant, recyclant et limitant le gaspillage.',
  ),
  'dro_027': QuestionCompletion(
    options: {
      'A': 'Autorisé si l’on prévient ses voisins',
      'B': 'Obligatoire le jour des encombrants',
      'C': 'Interdit',
      'D': 'Autorisé la nuit',
    },
    correctAnswer: 'C',
    explanation:
        'Déposer une machine à laver sur le trottoir sans autorisation est interdit.',
  ),
  'dro_028': QuestionCompletion(
    options: {
      'A': 'Le transport gratuit de voyageurs',
      'B': 'L’exploitation de personnes par la contrainte ou la tromperie',
      'C': 'Le travail saisonnier déclaré',
      'D': 'Le bénévolat associatif',
    },
    correctAnswer: 'B',
    explanation:
        'La traite des êtres humains consiste à exploiter des personnes pour en tirer profit.',
  ),
  'dro_029': QuestionCompletion(
    options: {
      'A': 'Garder le silence',
      'B': 'Demander de l’aide et alerter les services compétents',
      'C': 'Attendre plusieurs mois',
      'D': 'Quitter immédiatement son travail sans parler à personne',
    },
    correctAnswer: 'B',
    explanation:
        'Une victime de violences doit chercher de l’aide rapidement et signaler les faits.',
  ),
  'dro_030': QuestionCompletion(
    options: {
      'A': 'La contravention',
      'B': 'Le délit',
      'C': 'Le crime',
      'D': 'Le rappel à la loi',
    },
    correctAnswer: 'C',
    explanation: 'Le crime est l’infraction la plus grave.',
  ),

  // Histoire, géographie et culture
  'his_002': QuestionCompletion(
    options: {
      'A': 'Un empereur des Français',
      'B': 'Un roi d’Angleterre',
      'C': 'Un écrivain italien',
      'D': 'Un président américain',
    },
    correctAnswer: 'A',
    explanation:
        'Napoléon Ier a été empereur des Français au début du XIXe siècle.',
  ),
  'his_003': QuestionCompletion(
    options: {
      'A': 'Charles de Gaulle',
      'B': 'George Washington',
      'C': 'Nelson Mandela',
      'D': 'Winston Churchill',
    },
    correctAnswer: 'A',
    explanation: 'Charles de Gaulle est un personnage historique français.',
  ),
  'his_005': QuestionCompletion(
    options: {
      'A': 'La conquête de la Lune',
      'B': 'L’extermination des Juifs d’Europe par les nazis',
      'C': 'La création de l’Union européenne',
      'D': 'La guerre de Cent Ans',
    },
    correctAnswer: 'B',
    explanation:
        'La Shoah est l’extermination des Juifs d’Europe pendant la Seconde Guerre mondiale.',
  ),
  'his_006': QuestionCompletion(
    options: {
      'A': 'L’Algérie',
      'B': 'Le Japon',
      'C': 'Le Canada entier',
      'D': 'La Suède',
    },
    correctAnswer: 'A',
    explanation: 'L’Algérie a été colonisée par la France.',
  ),
  'his_007': QuestionCompletion(
    options: {
      'A': 'Jules Ferry',
      'B': 'Victor Hugo',
      'C': 'Louis XIV',
      'D': 'Georges Clemenceau',
    },
    correctAnswer: 'A',
    explanation: 'Jules Ferry a rendu l’école gratuite, laïque et obligatoire.',
  ),
  'his_011': QuestionCompletion(
    options: {
      'A': 'La fin de la Première Guerre mondiale',
      'B': 'Le début de la Révolution française',
      'C': 'La fête nationale',
      'D': 'La création de l’euro',
    },
    correctAnswer: 'A',
    explanation:
        'Le 11 novembre commémore l’armistice de 1918, qui marque la fin de la Première Guerre mondiale.',
  ),
  'his_012': QuestionCompletion(
    options: {
      'A': 'Charles de Gaulle',
      'B': 'François Mitterrand',
      'C': 'Jacques Chirac',
      'D': 'Georges Pompidou',
    },
    correctAnswer: 'A',
    explanation:
        'Charles de Gaulle a été le premier président de la Ve République.',
  ),
  'his_014': QuestionCompletion(
    options: {
      'A': '1881',
      'B': '1789',
      'C': '1945',
      'D': '1968',
    },
    correctAnswer: 'A',
    explanation: 'L’école publique primaire devient gratuite en 1881.',
  ),
  'his_016': QuestionCompletion(
    options: {
      'A': 'Louis XVI',
      'B': 'Louis XIV',
      'C': 'Napoléon Ier',
      'D': 'Henri IV',
    },
    correctAnswer: 'A',
    explanation:
        'Louis XVI était le roi de France au moment de la Révolution française.',
  ),
  'his_017': QuestionCompletion(
    options: {
      'A': 'Charles de Gaulle',
      'B': 'Napoléon Bonaparte',
      'C': 'Jules Ferry',
      'D': 'Jean Jaurès',
    },
    correctAnswer: 'A',
    explanation: 'Charles de Gaulle a fondé la Ve République.',
  ),
  'his_018': QuestionCompletion(
    options: {
      'A': 'La fête nationale française',
      'B': 'La rentrée scolaire',
      'C': 'La fin de la Seconde Guerre mondiale',
      'D': 'La journée de l’Europe',
    },
    correctAnswer: 'A',
    explanation: 'Le 14 juillet est la fête nationale française.',
  ),
  'his_019': QuestionCompletion(
    options: {
      'A': 'La guerre de Cent Ans',
      'B': 'La Première Guerre mondiale',
      'C': 'La Seconde Guerre mondiale',
      'D': 'La guerre d’Algérie',
    },
    correctAnswer: 'B',
    explanation: 'La guerre de 1914 à 1918 est la Première Guerre mondiale.',
  ),
  'his_020': QuestionCompletion(
    options: {
      'A': 'C’est l’année de la naissance de la Ve République.',
      'B': 'C’est l’année de la Révolution française.',
      'C': 'C’est l’année de l’abolition de l’esclavage.',
      'D': 'C’est l’année de l’entrée dans l’Union européenne.',
    },
    correctAnswer: 'A',
    explanation: 'En 1958, la Constitution de la Ve République est adoptée.',
  ),
  'his_021': QuestionCompletion(
    options: {
      'A': 'La Loire',
      'B': 'Le Nil',
      'C': 'Le Danube',
      'D': 'L’Amazone',
    },
    correctAnswer: 'A',
    explanation: 'La Loire est un grand fleuve français.',
  ),
  'his_022': QuestionCompletion(
    options: {
      'A': 'Marseille',
      'B': 'Madrid',
      'C': 'Rome',
      'D': 'Lisbonne',
    },
    correctAnswer: 'A',
    explanation: 'Marseille est une ville française.',
  ),
  'his_023': QuestionCompletion(
    options: {
      'A': 'L’océan Atlantique',
      'B': 'L’océan Indien',
      'C': 'L’océan Pacifique',
      'D': 'L’océan Arctique',
    },
    correctAnswer: 'A',
    explanation:
        'La côte ouest de la France métropolitaine est bordée par l’océan Atlantique.',
  ),
  'his_024': QuestionCompletion(
    options: {
      'A': 'La capitale de la France',
      'B': 'Une région italienne',
      'C': 'Une île espagnole',
      'D': 'Un département belge',
    },
    correctAnswer: 'A',
    explanation: 'Paris est la capitale de la France.',
  ),
  'his_027': QuestionCompletion(
    options: {
      'A': 'La Réunion',
      'B': 'La Sicile',
      'C': 'La Sardaigne',
      'D': 'La Crète',
    },
    correctAnswer: 'A',
    explanation: 'La Réunion est un département d’outre-mer français.',
  ),
  'his_029': QuestionCompletion(
    options: {
      'A': 'Marseille',
      'B': 'Clermont-Ferrand',
      'C': 'Dijon',
      'D': 'Limoges',
    },
    correctAnswer: 'A',
    explanation: 'Marseille est un grand port maritime français.',
  ),
  'his_030': QuestionCompletion(
    options: {
      'A': 'La mer Méditerranée',
      'B': 'La mer Baltique',
      'C': 'La mer Noire',
      'D': 'La mer du Nord',
    },
    correctAnswer: 'A',
    explanation:
        'Au sud de la France métropolitaine se trouve la mer Méditerranée.',
  ),
  'his_031': QuestionCompletion(
    options: {
      'A': 'Marseille',
      'B': 'Lille',
      'C': 'Strasbourg',
      'D': 'Orléans',
    },
    correctAnswer: 'A',
    explanation: 'Marseille est située au bord de la mer Méditerranée.',
  ),
  'his_032': QuestionCompletion(
    options: {
      'A': 'En mer Méditerranée, au sud-est de la France',
      'B': 'Dans l’océan Atlantique, à l’ouest de la Bretagne',
      'C': 'Dans la Manche, en face de Calais',
      'D': 'Dans les Alpes, entre la Suisse et l’Autriche',
    },
    correctAnswer: 'A',
    explanation: 'La Corse est une île française située en Méditerranée.',
  ),
  'his_033': QuestionCompletion(
    options: {
      'A': 'Les Alpes',
      'B': 'Les Pyrénées',
      'C': 'Le Massif central',
      'D': 'Les Vosges',
    },
    correctAnswer: 'A',
    explanation: 'Les Alpes se trouvent entre la France et l’Italie.',
  ),
  'his_034': QuestionCompletion(
    options: {
      'A': 'Un dramaturge et comédien',
      'B': 'Un peintre',
      'C': 'Un général',
      'D': 'Un musicien',
    },
    correctAnswer: 'A',
    explanation: 'Molière est un grand auteur de théâtre français.',
  ),
  'his_035': QuestionCompletion(
    options: {
      'A': 'Un poète',
      'B': 'Un scientifique',
      'C': 'Un roi',
      'D': 'Un navigateur',
    },
    correctAnswer: 'A',
    explanation: 'Charles Baudelaire est un poète français.',
  ),
  'his_036': QuestionCompletion(
    options: {
      'A': 'Une écrivaine',
      'B': 'Une peintre',
      'C': 'Une chanteuse',
      'D': 'Une reine',
    },
    correctAnswer: 'A',
    explanation: 'George Sand est une écrivaine française.',
  ),
  'his_037': QuestionCompletion(
    options: {
      'A': 'Une philosophe et écrivaine',
      'B': 'Une actrice',
      'C': 'Une sportive',
      'D': 'Une scientifique',
    },
    correctAnswer: 'A',
    explanation:
        'Simone de Beauvoir est une philosophe et écrivaine française.',
  ),
  'his_038': QuestionCompletion(
    options: {
      'A': 'Un écrivain et philosophe',
      'B': 'Un empereur',
      'C': 'Un chanteur',
      'D': 'Un architecte',
    },
    correctAnswer: 'A',
    explanation: 'Albert Camus est un écrivain et philosophe français.',
  ),
  'his_039': QuestionCompletion(
    options: {
      'A': 'Un peintre',
      'B': 'Un magistrat',
      'C': 'Un poète',
      'D': 'Un explorateur',
    },
    correctAnswer: 'A',
    explanation: 'Paul Cézanne est un peintre français.',
  ),
  'his_040': QuestionCompletion(
    options: {
      'A': 'Un peintre',
      'B': 'Un homme politique',
      'C': 'Un chanteur',
      'D': 'Un écrivain',
    },
    correctAnswer: 'A',
    explanation: 'Marc Chagall est un artiste peintre.',
  ),
  'his_041': QuestionCompletion(
    options: {
      'A': 'Une artiste et résistante',
      'B': 'Une reine de France',
      'C': 'Une scientifique',
      'D': 'Une ministre',
    },
    correctAnswer: 'A',
    explanation: 'Joséphine Baker était une artiste célèbre et une résistante.',
  ),
  'his_042': QuestionCompletion(
    options: {
      'A': 'Édith Piaf',
      'B': 'Marie Curie',
      'C': 'George Sand',
      'D': 'Simone Veil',
    },
    correctAnswer: 'A',
    explanation: 'Édith Piaf est une chanteuse française célèbre.',
  ),
  'his_043': QuestionCompletion(
    options: {
      'A': 'Un musée',
      'B': 'Un tribunal',
      'C': 'Une université',
      'D': 'Un stade',
    },
    correctAnswer: 'A',
    explanation: 'Le Louvre est un grand musée situé à Paris.',
  ),
  'his_044': QuestionCompletion(
    options: {
      'A': 'Un fabuliste',
      'B': 'Un astronaute',
      'C': 'Un roi',
      'D': 'Un architecte',
    },
    correctAnswer: 'A',
    explanation: 'Jean de La Fontaine est connu pour ses Fables.',
  ),
  'his_045': QuestionCompletion(
    options: {
      'A': 'Victor Hugo',
      'B': 'William Shakespeare',
      'C': 'Miguel de Cervantes',
      'D': 'Dante',
    },
    correctAnswer: 'A',
    explanation: 'Victor Hugo est un écrivain français.',
  ),
  'his_046': QuestionCompletion(
    options: {
      'A': 'Paris',
      'B': 'Lyon',
      'C': 'Bordeaux',
      'D': 'Toulouse',
    },
    correctAnswer: 'A',
    explanation: 'La tour Eiffel se trouve à Paris.',
  ),

  // Vivre dans la société française
  'viv_003': QuestionCompletion(
    options: {
      'A': 'Acheter un gilet fluorescent',
      'B': 'Assurer sa voiture',
      'C': 'Déclarer sa voiture à la mairie',
      'D': 'Changer de permis chaque année',
    },
    correctAnswer: 'B',
    explanation: 'Pour conduire légalement, le véhicule doit être assuré.',
  ),
  'viv_004': QuestionCompletion(
    options: {
      'A': 'S’il est célébré à la mairie par un officier d’état civil',
      'B': 'S’il est célébré uniquement dans un lieu de culte',
      'C': 'S’il est annoncé sur internet',
      'D': 'S’il est signé entre amis',
    },
    correctAnswer: 'A',
    explanation:
        'En France, seul le mariage civil célébré à la mairie est reconnu juridiquement.',
  ),
  'viv_005': QuestionCompletion(
    options: {
      'A': 'Dans les 5 jours suivant la naissance',
      'B': 'Dans le mois suivant la naissance',
      'C': 'Avant la naissance',
      'D': 'À l’entrée à l’école',
    },
    correctAnswer: 'A',
    explanation:
        'La naissance doit être déclarée à l’état civil dans les 5 jours.',
  ),
  'viv_006': QuestionCompletion(
    options: {
      'A': 'Autorisé si le salarié est d’accord',
      'B': 'Illégal',
      'C': 'Obligatoire pour les petits emplois',
      'D': 'Réservé aux étudiants',
    },
    correctAnswer: 'B',
    explanation: 'Le travail non déclaré est interdit par la loi.',
  ),
  'viv_007': QuestionCompletion(
    options: {
      'A': 'Respecter au minimum le SMIC',
      'B': 'Demander l’avis des voisins',
      'C': 'Fixer librement n’importe quel salaire',
      'D': 'Choisir un salaire différent chaque mois sans règle',
    },
    correctAnswer: 'A',
    explanation:
        'L’employeur doit au moins respecter le salaire minimum légal.',
  ),
  'viv_008': QuestionCompletion(
    options: {
      'A': 'Le salaire moyen en France',
      'B': 'Le salaire minimum légal',
      'C': 'Une prime versée par la mairie',
      'D': 'Une aide au logement',
    },
    correctAnswer: 'B',
    explanation:
        'Le SMIC est le salaire minimum interprofessionnel de croissance.',
  ),
  'viv_009': QuestionCompletion(
    options: {
      'A': 'S’inscrire à France Travail',
      'B': 'Attendre chez soi',
      'C': 'Ouvrir un compte bancaire',
      'D': 'Acheter une voiture',
    },
    correctAnswer: 'A',
    explanation:
        'France Travail aide les personnes à chercher un emploi et à être accompagnées.',
  ),
  'viv_011': QuestionCompletion(
    options: {
      'A': 'Les demandeurs d’emploi',
      'B': 'Seulement les retraités',
      'C': 'Seulement les élus',
      'D': 'Personne',
    },
    correctAnswer: 'A',
    explanation:
        'France Travail accompagne les personnes qui recherchent un emploi.',
  ),
  'viv_012': QuestionCompletion(
    options: {
      'A': 'Oui, sous certaines conditions',
      'B': 'Non, jamais',
      'C': 'Oui, sans aucune condition',
      'D': 'Seulement si elle est propriétaire',
    },
    correctAnswer: 'A',
    explanation:
        'Une personne étrangère en situation régulière peut créer une entreprise selon les règles applicables.',
  ),
  'viv_013': QuestionCompletion(
    options: {
      'A': 'Oui',
      'B': 'Non',
      'C': 'Oui, seulement après 40 ans',
      'D': 'Oui, seulement avec l’autorisation du mari',
    },
    correctAnswer: 'A',
    explanation: 'Une femme peut créer son entreprise comme un homme.',
  ),
  'viv_014': QuestionCompletion(
    options: {
      'A': '14 ans',
      'B': '15 ans',
      'C': '16 ans',
      'D': '18 ans',
    },
    correctAnswer: 'C',
    explanation:
        'En règle générale, un mineur peut travailler à partir de 16 ans.',
  ),
  'viv_015': QuestionCompletion(
    options: {
      'A': 'L’Assurance Maladie',
      'B': 'La mairie',
      'C': 'Le tribunal',
      'D': 'Le collège',
    },
    correctAnswer: 'A',
    explanation:
        'Les remboursements de soins dépendent de l’Assurance Maladie.',
  ),
  'viv_016': QuestionCompletion(
    options: {
      'A': 'Un numéro de téléphone pour appeler rapidement les secours',
      'B': 'Un numéro fiscal',
      'C': 'Un numéro de dossier scolaire',
      'D': 'Un numéro de compte bancaire',
    },
    correctAnswer: 'A',
    explanation:
        'Un numéro d’urgence sert à joindre vite les secours en cas de danger.',
  ),
  'viv_017': QuestionCompletion(
    options: {
      'A': 'Tout le monde a le droit d’être soigné.',
      'B': 'Les soins sont réservés aux salariés.',
      'C': 'On ne peut consulter un médecin qu’en urgence.',
      'D': 'Les soins ne concernent que les enfants.',
    },
    correctAnswer: 'A',
    explanation: 'L’accès aux soins est un droit important en France.',
  ),
  'viv_018': QuestionCompletion(
    options: {
      'A': 'Aux urgences de l’hôpital',
      'B': 'À son médecin traitant',
      'C': 'Au commissariat',
      'D': 'À la mairie',
    },
    correctAnswer: 'B',
    explanation:
        'En cas de problème non urgent, on s’adresse d’abord à son médecin traitant.',
  ),
  'viv_019': QuestionCompletion(
    options: {
      'A': 'Coordonner les soins et orienter si besoin',
      'B': 'Rendre la justice',
      'C': 'Distribuer les médicaments gratuitement',
      'D': 'Choisir la mutuelle à votre place',
    },
    correctAnswer: 'A',
    explanation:
        'Le médecin traitant suit le patient et l’oriente vers un spécialiste si nécessaire.',
  ),
  'viv_020': QuestionCompletion(
    options: {
      'A': 'Pour renouveler une ordonnance simple',
      'B': 'En cas d’urgence médicale grave',
      'C': 'Pour demander un certificat scolaire',
      'D': 'Pour un rhume léger',
    },
    correctAnswer: 'B',
    explanation:
        'Les urgences de l’hôpital sont réservées aux situations graves ou très urgentes.',
  ),
  'viv_021': QuestionCompletion(
    options: {
      'A': 'Protéger la santé individuelle et collective',
      'B': 'Éviter d’aller à l’école',
      'C': 'Remplacer tous les médecins',
      'D': 'Permettre de voyager gratuitement',
    },
    correctAnswer: 'A',
    explanation:
        'Les vaccinations obligatoires protègent contre des maladies graves.',
  ),
  'viv_022': QuestionCompletion(
    options: {
      'A': 'À payer moins d’impôts',
      'B': 'À obtenir le remboursement des soins',
      'C': 'À voter',
      'D': 'À conduire',
    },
    correctAnswer: 'B',
    explanation:
        'La carte Vitale facilite la prise en charge et le remboursement des frais de santé.',
  ),
  'viv_023': QuestionCompletion(
    options: {
      'A': 'À compléter les remboursements de l’Assurance Maladie',
      'B': 'À remplacer la carte Vitale',
      'C': 'À obtenir un permis de conduire',
      'D': 'À inscrire un enfant à l’école',
    },
    correctAnswer: 'A',
    explanation:
        'Une mutuelle santé complète ce que rembourse l’Assurance Maladie.',
  ),
  'viv_025': QuestionCompletion(
    options: {
      'A': 'De protéger, entretenir et éduquer l’enfant',
      'B': 'De laisser l’enfant décider seul de tout',
      'C': 'De supprimer l’école obligatoire',
      'D': 'D’interdire les soins médicaux',
    },
    correctAnswer: 'A',
    explanation:
        'L’autorité parentale impose aux parents de protéger et d’éduquer leur enfant.',
  ),
  'viv_026': QuestionCompletion(
    options: {
      'A': 'Pour tous les enfants de 3 à 16 ans',
      'B': 'Seulement pour les garçons',
      'C': 'Seulement pour les enfants français',
      'D': 'Uniquement jusqu’à 11 ans',
    },
    correctAnswer: 'A',
    explanation:
        'L’instruction est obligatoire pour tous les enfants de 3 à 16 ans.',
  ),
  'viv_027': QuestionCompletion(
    options: {
      'A': 'Le baccalauréat',
      'B': 'Le brevet',
      'C': 'La licence',
      'D': 'Le CAP de droit',
    },
    correctAnswer: 'A',
    explanation: 'À la fin du lycée, on peut obtenir le baccalauréat.',
  ),
  'viv_028': QuestionCompletion(
    options: {
      'A': 'Au collège',
      'B': 'À l’université',
      'C': 'À la mairie',
      'D': 'Au Sénat',
    },
    correctAnswer: 'A',
    explanation: 'Après l’école élémentaire, les élèves vont au collège.',
  ),
  'viv_029': QuestionCompletion(
    options: {
      'A': 'Pour tous les enfants de 3 à 16 ans',
      'B': 'Seulement pour les enfants français',
      'C': 'Seulement pour les filles',
      'D': 'Seulement jusqu’à 10 ans',
    },
    correctAnswer: 'A',
    explanation:
        'L’école est obligatoire pour tous les enfants entre 3 et 16 ans.',
  ),
  'viv_030': QuestionCompletion(
    options: {
      'A': 'Peut venir seulement quand il veut',
      'B': 'Doit fréquenter l’école avec assiduité',
      'C': 'N’est pas obligé d’apprendre le français',
      'D': 'Peut refuser les cours obligatoires',
    },
    correctAnswer: 'B',
    explanation: 'Un enfant inscrit à l’école doit y aller régulièrement.',
  ),
  'viv_031': QuestionCompletion(
    options: {
      'A': 'Ne peuvent pas aller à l’école',
      'B': 'Peuvent être scolarisés et aidés pour apprendre le français',
      'C': 'Doivent attendre 16 ans',
      'D': 'Sont obligés d’étudier à la maison',
    },
    correctAnswer: 'B',
    explanation:
        'Les enfants non francophones ont droit à l’école et peuvent être accompagnés pour apprendre le français.',
  ),
};
