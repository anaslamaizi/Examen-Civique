import '../models/question.dart';
import 'question_metadata.dart';

// Questions locales complémentaires rédigées à partir des thématiques
// officielles de l'examen civique du ministère de l'Intérieur.
const supplementalQuestions = <Question>[
  Question(
    id: 'pri_101',
    section: principlesAndValuesSection,
    question:
        "Une des valeurs de la devise républicaine est l'égalité. Qu'est-ce que cela signifie ?",
    options: {
      'A':
          'Toutes les personnes ont les mêmes droits et les mêmes devoirs devant la loi.',
      'B': 'Toutes les personnes doivent avoir le même métier.',
      'C': 'Seuls les citoyens français sont égaux.',
      'D': "L'État choisit la religion de chacun.",
    },
    correctAnswer: 'A',
    explanation:
        "L'égalité garantit que la loi s'applique à toutes et à tous sans discrimination.",
    draft: false,
  ),
  Question(
    id: 'sys_101',
    section: institutionsSection,
    question: "Qui dirige l'action du Gouvernement ?",
    options: {
      'A': 'Le président de la République',
      'B': 'Le Premier ministre',
      'C': 'Le président du Sénat',
      'D': 'Le Conseil constitutionnel',
    },
    correctAnswer: 'B',
    explanation: "Le Premier ministre dirige l'action du Gouvernement.",
    draft: false,
  ),
  Question(
    id: 'sys_103',
    section: institutionsSection,
    question: "Qu'est-ce que l'État de droit ?",
    options: {
      'A':
          'Un État où les personnes et les institutions doivent respecter la loi.',
      'B': 'Un État dirigé uniquement par l’armée.',
      'C': 'Un État sans élections.',
      'D': 'Un État où le gouvernement peut agir hors la loi.',
    },
    correctAnswer: 'A',
    explanation: "Dans un État de droit, personne n'est au-dessus de la loi.",
    draft: false,
  ),
  Question(
    id: 'his_101',
    section: historyGeographyCultureSection,
    question:
        'Quel roi de France a été exécuté pendant la Révolution française ?',
    options: {
      'A': 'Louis XIII',
      'B': 'Louis XIV',
      'C': 'Louis XVI',
      'D': 'Charles X',
    },
    correctAnswer: 'C',
    explanation:
        'Louis XVI a été exécuté en 1793 pendant la Révolution française.',
    draft: false,
  ),
  Question(
    id: 'his_102',
    section: historyGeographyCultureSection,
    question: "En 1944, qu'est-ce qui a changé pour les femmes ?",
    options: {
      'A': 'Elles ont obtenu le droit de vote.',
      'B': "Elles ont été dispensées d'école.",
      'C': 'Elles ont perdu le droit de travailler.',
      'D': 'Elles ont cessé de payer des impôts.',
    },
    correctAnswer: 'A',
    explanation: 'Les femmes obtiennent le droit de vote en France en 1944.',
    draft: false,
  ),
  Question(
    id: 'his_103',
    section: historyGeographyCultureSection,
    question: 'Quel fleuve traverse Paris ?',
    options: {
      'A': 'Le Rhône',
      'B': 'La Seine',
      'C': 'La Loire',
      'D': 'La Garonne',
    },
    correctAnswer: 'B',
    explanation:
        'La Seine traverse Paris et structure une grande partie de la ville.',
    draft: false,
  ),
  Question(
    id: 'dro_101',
    section: rightsAndDutiesSection,
    question:
        'Quelle liberté permet à une personne de croire en la religion de son choix ?',
    options: {
      'A': 'La liberté de culte',
      'B': 'La liberté de circulation',
      'C': 'Le droit de grève',
      'D': 'Le droit de vote',
    },
    correctAnswer: 'A',
    explanation:
        'La liberté de culte permet de pratiquer la religion de son choix dans le respect de la loi.',
    draft: false,
  ),
  Question(
    id: 'dro_102',
    section: rightsAndDutiesSection,
    question: 'Que garantit la liberté de la presse ?',
    options: {
      'A':
          "Le droit d'informer et d'exprimer des opinions dans le respect de la loi",
      'B': 'Le droit de publier des informations fausses sans limite',
      'C': "Le droit d'insulter publiquement quelqu'un",
      'D': 'Le droit de censurer les autres journaux',
    },
    correctAnswer: 'A',
    explanation:
        "La liberté de la presse protège l'information et le débat public, avec des limites prévues par la loi.",
    draft: false,
  ),
  Question(
    id: 'dro_103',
    section: rightsAndDutiesSection,
    question: 'Jeter un mégot par terre est :',
    options: {
      'A': 'Un geste sans conséquence',
      'B': 'Interdit et passible d’une amende',
      'C': 'Autorisé seulement la nuit',
      'D': 'Obligatoire dans les espaces publics',
    },
    correctAnswer: 'B',
    explanation:
        'Jeter un mégot par terre est interdit et nuit à la propreté comme à l’environnement.',
    draft: false,
  ),
  Question(
    id: 'dro_104',
    section: rightsAndDutiesSection,
    question: 'Vous êtes victime de violences. Que devez-vous faire ?',
    options: {
      'A': 'Garder le silence',
      'B':
          "Demander de l'aide et contacter les services compétents ou la police",
      'C': 'Attendre plusieurs mois avant d’en parler',
      'D': "Quitter définitivement l'école ou le travail",
    },
    correctAnswer: 'B',
    explanation:
        "En cas de violences, il faut chercher de l'aide rapidement et signaler les faits.",
    draft: false,
  ),
  Question(
    id: 'dro_105',
    section: rightsAndDutiesSection,
    question:
        'Quelle obligation concerne toutes les personnes résidant en France quelle que soit leur nationalité ?',
    options: {
      'A': 'Respecter la loi',
      'B': 'Voter à toutes les élections',
      'C': 'Faire un service militaire',
      'D': 'Être propriétaire de son logement',
    },
    correctAnswer: 'A',
    explanation:
        'Le respect de la loi concerne toutes les personnes vivant en France.',
    draft: false,
  ),
  Question(
    id: 'viv_101',
    section: societySection,
    question: "Où faut-il déclarer la naissance d'un enfant ?",
    options: {
      'A': 'À la mairie du lieu de naissance',
      'B': 'À la préfecture',
      'C': "À l'école la plus proche",
      'D': "À l'hôpital uniquement",
    },
    correctAnswer: 'A',
    explanation:
        "La naissance doit être déclarée à l'état civil de la mairie du lieu de naissance.",
    draft: false,
  ),
  Question(
    id: 'viv_102',
    section: societySection,
    question: 'Quelle est la mission de France Travail ?',
    options: {
      'A':
          "Accompagner les personnes dans leur recherche d'emploi ou de formation",
      'B': "Délivrer les cartes d'identité",
      'C': 'Remplacer les employeurs privés',
      'D': 'Gérer les tribunaux du travail',
    },
    correctAnswer: 'A',
    explanation:
        "France Travail aide les personnes à trouver un emploi et à construire un parcours adapté.",
    draft: false,
  ),
  Question(
    id: 'viv_103',
    section: societySection,
    question: "À quel âge commence l'instruction obligatoire des enfants ?",
    options: {
      'A': '2 ans',
      'B': '3 ans',
      'C': '6 ans',
      'D': '7 ans',
    },
    correctAnswer: 'B',
    explanation: "En France, l'instruction est obligatoire à partir de 3 ans.",
    draft: false,
  ),
  Question(
    id: 'viv_104',
    section: societySection,
    question:
        'Après avoir obtenu le permis de conduire, que faut-il faire avant de conduire sa voiture ?',
    options: {
      'A': 'Acheter un gilet fluorescent',
      'B': 'Prendre une assurance automobile',
      'C': 'Déclarer sa voiture à la mairie',
      'D': 'Changer de permis chaque année',
    },
    correctAnswer: 'B',
    explanation:
        "Pour conduire légalement, le véhicule doit notamment être assuré.",
    draft: false,
  ),
];
