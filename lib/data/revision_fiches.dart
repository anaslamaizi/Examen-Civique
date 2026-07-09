import '../models/revision_fiche.dart';

const revisionFiches = <RevisionFiche>[
  RevisionFiche(
    slug: 'devise-symboles-republique',
    title: 'La devise et les symboles de la République',
    theme: 'Principes & Valeurs',
    subtitle: 'Les symboles fondamentaux qui représentent la France républicaine.',
    summary: 'Une fiche courte pour retenir la devise, le drapeau, Marianne, la Marseillaise et le 14 juillet.',
    questionCount: 11,
    keyPoints: [
      'Devise : Liberté, Égalité, Fraternité',
      'Drapeau : bleu, blanc, rouge',
      'Marianne porte un bonnet phrygien',
      'La Marseillaise est l’hymne national',
      'Le 14 juillet est la fête nationale',
    ],
    sections: [
      RevisionContentSection(
        title: 'La devise',
        items: [
          'Liberté : pouvoir agir sans nuire à autrui.',
          'Égalité : mêmes droits pour tous devant la loi.',
          'Fraternité : solidarité entre les citoyens.',
          'La devise figure sur les bâtiments publics comme les mairies, écoles et tribunaux.',
        ],
      ),
      RevisionContentSection(
        title: 'Les symboles officiels',
        items: [
          'Le drapeau tricolore est bleu, blanc, rouge.',
          'Marianne est une figure féminine symbole de liberté.',
          'La Marseillaise est l’hymne national.',
          'Le coq est un symbole traditionnel de la France.',
        ],
      ),
    ],
    pitfalls: [
      'Confondre Marianne avec une reine : elle porte un bonnet phrygien, pas une couronne.',
      'Croire que le coq est inscrit dans la Constitution : il est surtout traditionnel.',
      'Oublier que le 14 juillet renvoie à la prise de la Bastille et à la Fête de la Fédération.',
    ],
  ),
  RevisionFiche(
    slug: 'laicite',
    title: 'La laïcité',
    theme: 'Principes & Valeurs',
    subtitle: 'Le principe de séparation des religions et de l’État.',
    summary: 'Comprendre ce que la laïcité garantit dans la République française.',
    questionCount: 9,
    keyPoints: [
      'L’État est neutre face aux religions.',
      'Chacun est libre de croire ou de ne pas croire.',
      'La loi protège la liberté de conscience.',
    ],
    sections: [
      RevisionContentSection(
        title: 'Définition simple',
        items: [
          'La laïcité garantit la liberté de conscience.',
          'Elle impose la neutralité de l’État et des services publics.',
          'Elle permet à chacun de pratiquer sa religion dans le respect de la loi.',
        ],
      ),
      RevisionContentSection(
        title: 'À l’école et dans les services publics',
        items: [
          'Les agents publics doivent rester neutres.',
          'Les usagers sont accueillis sans discrimination.',
          'La règle commune s’applique à tous.',
        ],
      ),
    ],
    pitfalls: [
      'Penser que la laïcité interdit les religions : elle protège la liberté de conscience.',
      'Confondre neutralité de l’État et neutralité de toute la société.',
    ],
  ),
  RevisionFiche(
    slug: 'president-gouvernement',
    title: 'Le Président et le Gouvernement',
    theme: 'Institutions',
    subtitle: 'L’organisation du pouvoir exécutif en France.',
    summary: 'Retenir le rôle du Président, du Premier ministre et du Gouvernement.',
    questionCount: 12,
    isPremium: true,
    keyPoints: [
      'Le Président est élu au suffrage universel direct.',
      'Le Premier ministre dirige l’action du Gouvernement.',
      'Le Gouvernement conduit la politique de la Nation.',
    ],
    sections: [
      RevisionContentSection(
        title: 'Le Président de la République',
        items: [
          'Il est le chef de l’État.',
          'Il nomme le Premier ministre.',
          'Il promulgue les lois et peut dissoudre l’Assemblée nationale.',
        ],
      ),
      RevisionContentSection(
        title: 'Le Gouvernement',
        items: [
          'Il prépare et exécute les lois.',
          'Il est composé du Premier ministre et des ministres.',
          'Il est responsable devant le Parlement.',
        ],
      ),
    ],
    pitfalls: [
      'Confondre Président et Premier ministre.',
      'Oublier que le Gouvernement est responsable devant le Parlement.',
    ],
  ),
  RevisionFiche(
    slug: 'parlement-loi',
    title: 'Le Parlement et la loi',
    theme: 'Institutions',
    subtitle: 'Comment les lois sont discutées et votées.',
    summary: 'Comprendre le rôle de l’Assemblée nationale et du Sénat.',
    questionCount: 10,
    isPremium: true,
    keyPoints: [
      'Le Parlement vote la loi.',
      'Il contrôle l’action du Gouvernement.',
      'Il est composé de l’Assemblée nationale et du Sénat.',
    ],
    sections: [
      RevisionContentSection(
        title: 'Les deux chambres',
        items: [
          'L’Assemblée nationale représente les citoyens.',
          'Le Sénat représente les collectivités territoriales.',
          'Les deux chambres examinent les textes de loi.',
        ],
      ),
      RevisionContentSection(
        title: 'Le vote de la loi',
        items: [
          'Une loi peut venir du Gouvernement ou du Parlement.',
          'Le texte est discuté, amendé puis voté.',
          'La promulgation revient au Président de la République.',
        ],
      ),
    ],
    pitfalls: [
      'Dire que seul le Président vote la loi.',
      'Oublier le rôle de contrôle du Parlement.',
    ],
  ),
  RevisionFiche(
    slug: 'droits-devoirs',
    title: 'Droits et devoirs du citoyen',
    theme: 'Droits & Devoirs',
    subtitle: 'Les libertés, obligations et règles de vie commune.',
    summary: 'Une fiche pour réviser les droits essentiels et les devoirs citoyens.',
    questionCount: 13,
    isPremium: true,
    keyPoints: [
      'Chaque citoyen a des droits et des devoirs.',
      'La loi est la même pour tous.',
      'Voter est un droit civique majeur.',
    ],
    sections: [
      RevisionContentSection(
        title: 'Les droits',
        items: [
          'Liberté d’expression, liberté de conscience et égalité devant la loi.',
          'Accès à l’éducation et à la protection sociale selon les règles applicables.',
          'Droit de vote pour les citoyens français majeurs inscrits.',
        ],
      ),
      RevisionContentSection(
        title: 'Les devoirs',
        items: [
          'Respecter la loi et les autres personnes.',
          'Payer ses impôts selon sa situation.',
          'Participer à la vie citoyenne.',
        ],
      ),
    ],
    pitfalls: [
      'Oublier que les droits s’accompagnent de devoirs.',
      'Confondre carte de séjour et nationalité française pour le droit de vote national.',
    ],
  ),
  RevisionFiche(
    slug: 'vie-quotidienne',
    title: 'La vie quotidienne en France',
    theme: 'Vie quotidienne',
    subtitle: 'Repères pratiques pour vivre et s’intégrer en France.',
    summary: 'Santé, école, travail, logement et règles de vie commune.',
    questionCount: 8,
    isPremium: true,
    keyPoints: [
      'L’école est obligatoire de 3 à 16 ans.',
      'La Sécurité sociale protège contre certains risques.',
      'Le respect des règles communes facilite la vie collective.',
    ],
    sections: [
      RevisionContentSection(
        title: 'École et santé',
        items: [
          'L’école transmet les savoirs et les valeurs de la République.',
          'Le système de santé repose sur des droits et des démarches administratives.',
          'Les services publics accompagnent les habitants dans leurs démarches.',
        ],
      ),
      RevisionContentSection(
        title: 'Travail et logement',
        items: [
          'Un contrat de travail fixe les droits et obligations du salarié et de l’employeur.',
          'Un bail encadre la relation entre locataire et propriétaire.',
          'Les règles de voisinage protègent la tranquillité de tous.',
        ],
      ),
    ],
    pitfalls: [
      'Confondre aides sociales et droits automatiques sans conditions.',
      'Oublier que beaucoup de démarches demandent des justificatifs.',
    ],
  ),
];
