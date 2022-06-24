# A treemap R script produced by the Revigo server at http://revigo.irb.hr/
# If you found Revigo useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# author: Anton Kratz <anton.kratz@gmail.com>, RIKEN Omics Science Center, Functional Genomics Technology Team, Japan
# created: Fri, Nov 02, 2012  7:25:52 PM
# last change: Fri, Nov 09, 2012  3:20:01 PM

# -----------------------------------------------------------------------------
# If you don't have the treemap package installed, uncomment the following line:
# install.packages( "treemap" );
library(treemap) 								# treemap package by Martijn Tennekes

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from Revigo. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency","value","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0006403","RNA localization",1.0137784250028,2.2226858987155,0.932677947618938,0,"RNA localization"),
c("GO:0071166","ribonucleoprotein complex localization",0.00560098577349614,2.21940109512862,0.950010404350624,0.1213004,"RNA localization"),
c("GO:0051168","nuclear export",0.728128150554498,2.20648011510637,0.891450758796954,0.24129281,"RNA localization"),
c("GO:0045185","maintenance of protein location",0.515290691161644,1.85438997945684,0.934351703386216,0.36025115,"RNA localization"),
c("GO:0051904","pigment granule transport",0.123221687016915,2.01144097488043,0.92776504524881,0.36097935,"RNA localization"),
c("GO:0051028","mRNA transport",0.722527164781002,2.38824656295325,0.890203664646699,0.37304026,"RNA localization"),
c("GO:0034504","protein localization to nucleus",1.06978828273776,1.77555417871913,0.905729259343812,0.40807356,"RNA localization"),
c("GO:0032456","endocytic recycling",0.392069004144729,1.93009140145139,0.909273443577606,0.45526169,"RNA localization"),
c("GO:0015931","nucleobase-containing compound transport",1.22661588439565,1.95940724732108,0.924952720644958,0.47480415,"RNA localization"),
c("GO:0048193","Golgi vesicle transport",1.63548784586087,1.72735233745146,0.935447861225632,0.49036005,"RNA localization"),
c("GO:0051169","nuclear transport",1.37224151450655,1.93614279634412,0.905340857097688,0.51717942,"RNA localization"),
c("GO:0006888","endoplasmic reticulum to Golgi vesicle-mediated transport",0.750532093648482,1.79345170706895,0.907828146036564,0.52571812,"RNA localization"),
c("GO:1990778","protein localization to cell periphery",1.32183264254509,1.62929312817881,0.905422974653727,0.54654386,"RNA localization"),
c("GO:0015695","organic cation transport",0.196034502072365,2.06191410116347,0.939555550565467,0,"organic cation transport"),
c("GO:0043467","regulation of generation of precursor metabolites and energy",0.728128150554498,2.2342785433623,0.921017061686066,0,"regulation of generation of precursor metabolites and energy"),
c("GO:0040029","regulation of gene expression, epigenetic",0.649714349725552,2.14414857180592,0.851169971399564,0.12116559,"regulation of generation of precursor metabolites and energy"),
c("GO:0090311","regulation of protein deacetylation",0.336059146409768,2.10670229966968,0.900664081342577,0.13431627,"regulation of generation of precursor metabolites and energy"),
c("GO:0051131","chaperone-mediated protein complex assembly",0.123221687016915,2.12276842142075,0.95198373486333,0.14023362,"regulation of generation of precursor metabolites and energy"),
c("GO:1903311","regulation of mRNA metabolic process",1.69709868936933,2.02782393661283,0.89492030342623,0.15848756,"regulation of generation of precursor metabolites and energy"),
c("GO:0035303","regulation of dephosphorylation",0.750532093648482,1.72826086732122,0.9180330460767,0.15902311,"regulation of generation of precursor metabolites and energy"),
c("GO:0060964","regulation of miRNA-mediated gene silencing",0.212837459392853,1.92382949991583,0.916848439851431,0.16927572,"regulation of generation of precursor metabolites and energy"),
c("GO:0060147","regulation of post-transcriptional gene silencing",0.229640416713342,2.01169255427316,0.916312698455064,0.17043317,"regulation of generation of precursor metabolites and energy"),
c("GO:0060966","regulation of gene silencing by RNA",0.235241402486838,2.01169255427316,0.916141362119615,0.17080355,"regulation of generation of precursor metabolites and energy"),
c("GO:0006109","regulation of carbohydrate metabolic process",1.0081774392293,1.75006412681989,0.919444744159679,0.17180614,"regulation of generation of precursor metabolites and energy"),
c("GO:0032922","circadian regulation of gene expression",0.397669989918226,2.07788010487574,0.906995280828878,0.1792924,"regulation of generation of precursor metabolites and energy"),
c("GO:0034330","cell junction organization",2.7500840147866,1.70528456711754,0.953114550923107,0.19069541,"regulation of generation of precursor metabolites and energy"),
c("GO:0034248","regulation of cellular amide metabolic process",2.80049288674807,1.89981285725442,0.905591988177996,0.20210674,"regulation of generation of precursor metabolites and energy"),
c("GO:0050808","synapse organization",1.65789178895486,1.82881405210951,0.948891378287308,0.21391572,"regulation of generation of precursor metabolites and energy"),
c("GO:0022411","cellular component disassembly",1.78671446174527,1.60412122488289,0.955286831176136,0.21601692,"regulation of generation of precursor metabolites and energy"),
c("GO:0010608","post-transcriptional regulation of gene expression",2.99652738882043,1.90873132339094,0.893110974955734,0.22167208,"regulation of generation of precursor metabolites and energy"),
c("GO:0010256","endomembrane system organization",3.09174414696987,1.66850851323317,0.952490981989472,0.23277149,"regulation of generation of precursor metabolites and energy"),
c("GO:1903312","negative regulation of mRNA metabolic process",0.515290691161644,2.12485618051468,0.826471165748374,0.26422221,"regulation of generation of precursor metabolites and energy"),
c("GO:0007033","vacuole organization",0.991374481908816,1.7783587833511,0.947280993367278,0.27641378,"regulation of generation of precursor metabolites and energy"),
c("GO:0043484","regulation of RNA splicing",1.0081774392293,1.87710181368751,0.8895309488996,0.28466865,"regulation of generation of precursor metabolites and energy"),
c("GO:0007005","mitochondrion organization",2.4644337403383,1.69771377709727,0.942040994229192,0.32072167,"regulation of generation of precursor metabolites and energy"),
c("GO:0009895","negative regulation of catabolic process",1.84832530525372,1.94865731184168,0.829754554662194,0.32439264,"regulation of generation of precursor metabolites and energy"),
c("GO:0017148","negative regulation of translation",0.929763638400358,2.06444619260551,0.78737904235931,0.35099875,"regulation of generation of precursor metabolites and energy"),
c("GO:0060304","regulation of phosphatidylinositol dephosphorylation",0.0336059146409768,1.90581140296328,0.932250811086202,0.36488529,"regulation of generation of precursor metabolites and energy"),
c("GO:0030036","actin cytoskeleton organization",3.0469362607819,1.63915208422684,0.94068382216543,0.37077645,"regulation of generation of precursor metabolites and energy"),
c("GO:0010257","NADH dehydrogenase complex assembly",0.330458160636272,2.05193562519069,0.947921262529475,0.39763007,"regulation of generation of precursor metabolites and energy"),
c("GO:0033108","mitochondrial respiratory chain complex assembly",0.537694634255629,1.87354978371318,0.935385226502715,0.45118889,"regulation of generation of precursor metabolites and energy"),
c("GO:0032984","protein-containing complex disassembly",0.778537022515963,1.84522094544092,0.94650198833387,0.46245052,"regulation of generation of precursor metabolites and energy"),
c("GO:0031047","gene silencing by RNA",0.526492662708637,1.90617269651145,0.846980433647714,0.57492806,"regulation of generation of precursor metabolites and energy"),
c("GO:0000956","nuclear-transcribed mRNA catabolic process",0.576901534670102,2.04788776509622,0.640357879187064,0.58027402,"regulation of generation of precursor metabolites and energy"),
c("GO:0031507","heterochromatin assembly",0.291251260221799,2.09020837099349,0.79629714908138,0.60772084,"regulation of generation of precursor metabolites and energy"),
c("GO:0042177","negative regulation of protein catabolic process",0.700123221687017,2.05155933631795,0.821167369678453,0.61130559,"regulation of generation of precursor metabolites and energy"),
c("GO:0016241","regulation of macroautophagy",0.890556737985886,1.9013392575332,0.861316387678597,0.62818746,"regulation of generation of precursor metabolites and energy"),
c("GO:0035194","post-transcriptional gene silencing by RNA",0.229640416713342,1.89676619460054,0.821280753999811,0.63278371,"regulation of generation of precursor metabolites and energy"),
c("GO:0016441","post-transcriptional gene silencing",0.257645345580822,1.94151359496686,0.831873855146748,0.63962756,"regulation of generation of precursor metabolites and energy"),
c("GO:0010498","proteasomal protein catabolic process",2.09476867928755,1.55162975387537,0.791308956971628,0.64204206,"regulation of generation of precursor metabolites and energy"),
c("GO:0006325","chromatin organization",3.28217766326873,1.72274421346043,0.926543230526595,0.65879531,"regulation of generation of precursor metabolites and energy"),
c("GO:0032981","mitochondrial respiratory chain complex I assembly",0.330458160636272,2.05193562519069,0.938003406261197,0.66043492,"regulation of generation of precursor metabolites and energy"),
c("GO:0045974","regulation of translation, ncRNA-mediated",0.195883619990259,2.01119773630669,0.851331710244888,0.6614847,"regulation of generation of precursor metabolites and energy"),
c("GO:1900151","regulation of nuclear-transcribed mRNA catabolic process, deadenylation-dependent decay",0.1456256301109,2.03813549446365,0.782101584602038,0.67916012,"regulation of generation of precursor metabolites and energy"),
c("GO:1900153","positive regulation of nuclear-transcribed mRNA catabolic process, deadenylation-dependent decay",0.084014786602442,2.03813549446365,0.784937521885068,0.68085242,"regulation of generation of precursor metabolites and energy"),
c("GO:0010506","regulation of autophagy",1.93234009185617,1.82336347812318,0.850388282221519,0.68949515,"regulation of generation of precursor metabolites and energy"),
c("GO:0045622","regulation of T-helper cell differentiation",0.235241402486838,2.10714961802142,0.946903094977668,0,"regulation of T-helper cell differentiation"),
c("GO:0071638","negative regulation of monocyte chemotactic protein-1 production",0.0336059146409768,2.4615181631847,0.872005690013268,0.22708851,"regulation of T-helper cell differentiation"),
c("GO:0048702","embryonic neurocranium morphogenesis",0.0504088719614652,2.11227771110722,0.989822391072572,0,"embryonic neurocranium morphogenesis"),
c("GO:0048675","axon extension",0.268847317127815,1.96157928608561,0.945672310771438,0.27051675,"embryonic neurocranium morphogenesis"),
c("GO:0051084","'de novo' post-translational protein folding",0.207236473619357,NaN,0.995098823608602,0,"'de novo' post-translational protein folding"),
c("GO:0098789","pre-mRNA cleavage required for polyadenylation",0.0728128150554498,2.47128134093157,0.825438241548151,0.00355824,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0016575","histone deacetylation",0.341660132183264,2.22213070575586,0.827109222650317,0.11950202,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0050651","dermatan sulfate proteoglycan biosynthetic process",0.0448078861879691,2.10500268222455,0.868470065440058,0.17806258,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0009208","pyrimidine ribonucleoside triphosphate metabolic process",0.10081774392293,2.02248722769576,0.85716591078031,0.22869803,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0006283","transcription-coupled nucleotide-excision repair",0.0560098577349614,1.89298387619786,0.847465203814461,0.25167178,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0098732","macromolecule deacylation",0.448078861879691,2.27618516845082,0.880214739472058,0.27503154,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0043687","post-translational protein modification",0.280049288674807,1.5456060388201,0.861580073524719,0.28075998,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0070936","protein K48-linked ubiquitination",0.358463089503753,2.13679787574393,0.850434134658469,0.28688794,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0009303","rRNA transcription",0.117620701243419,2.09253254713836,0.8397979251309,0.32885581,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0016570","histone modification",2.27960120981293,1.97066831806221,0.830680211734275,0.34473753,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0009267","cellular response to starvation",0.940965609947351,1.76458946387929,0.966378721446762,0.36466028,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0016311","dephosphorylation",1.38344348605355,1.75708150914585,0.902793925532435,0.36805795,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0043543","protein acylation",1.09779321160524,1.6891600414007,0.842874049665923,0.39126343,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0018205","peptidyl-lysine modification",1.7419065755573,1.78645204931145,0.821936492280412,0.41432939,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0043604","amide biosynthetic process",2.8957096448975,1.79161492601261,0.836758353315024,0.44591896,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0006470","protein dephosphorylation",1.02498039654979,1.727081063655,0.828645125176028,0.46438564,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0000380","alternative mRNA splicing, via spliceosome",0.134423658563907,2.23263479259271,0.82420778871113,0.5196378,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0006353","DNA-templated transcription, termination",0.1456256301109,1.84147153307061,0.837086537998551,0.52576138,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0016579","protein deubiquitination",0.845748851797916,1.61401258656947,0.828036555861272,0.54655315,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0006220","pyrimidine nucleotide metabolic process",0.291251260221799,1.97088980256048,0.836619340511698,0.55568072,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0000209","protein polyubiquitination",1.27702475635712,1.84823932531311,0.831798679721086,0.62824795,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0070646","protein modification by small protein removal",0.946566595720847,1.74266971890296,0.826165028334609,0.63035216,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0046513","ceramide biosynthetic process",0.31925618908928,1.93497211906188,0.849124422416521,0.63836794,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0006379","mRNA cleavage",0.112019715469923,2.05861628063254,0.833511542590369,0.65764682,"pre-mRNA cleavage required for polyadenylation"),
c("GO:0016573","histone acetylation",0.711325193234009,2.03808914276881,0.800952135327132,0.69553077,"pre-mRNA cleavage required for polyadenylation"),
c("GO:1990090","cellular response to nerve growth factor stimulus",0.257645345580822,2.28702259893057,0.974849302975131,0.00392861,"cellular response to nerve growth factor stimulus"),
c("GO:0007264","small GTPase mediated signal transduction",1.50106418729696,1.73211634661412,0.94994464614959,0.12599957,"cellular response to nerve growth factor stimulus"),
c("GO:0030520","intracellular estrogen receptor signaling pathway",0.117620701243419,1.92506340679001,0.955929769445376,0.41194208,"cellular response to nerve growth factor stimulus"),
c("GO:0007265","Ras protein signal transduction",1.08099025428475,1.63381539409839,0.951418091085916,0.51996397,"cellular response to nerve growth factor stimulus"),
c("GO:1990089","response to nerve growth factor",0.268847317127815,2.26465061427916,0.982377304299038,0.58325598,"cellular response to nerve growth factor stimulus"),
c("GO:0061919","process utilizing autophagic mechanism",1.68589671782234,1.68499287063429,0.993966585342983,0.0047485,"process utilizing autophagic mechanism"),
c("GO:0030029","actin filament-based process",3.39419737873866,1.53329404265374,0.99346215133665,0.00638831,"actin filament-based process"),
c("GO:0055078","sodium ion homeostasis",0.212837459392853,2.93950465702912,0.976782009490658,0.01716794,"sodium ion homeostasis"),
c("GO:0043547","positive regulation of GTPase activity",1.5906799596729,1.69862245725224,0.974259962786714,0.02311808,"positive regulation of GTPase activity"),
c("GO:0043087","regulation of GTPase activity",2.09476867928755,1.81144839663929,0.973702650037458,0.67605889,"positive regulation of GTPase activity"),
c("GO:0046831","regulation of RNA export from nucleus",0.0728128150554498,2.1057970288567,0.946664892411823,0.02725566,"regulation of RNA export from nucleus"),
c("GO:0032239","regulation of nucleobase-containing compound transport",0.0896157723759382,2.19302793788334,0.959890007775975,0.29600827,"regulation of RNA export from nucleus"),
c("GO:0032880","regulation of protein localization",4.62081326313431,1.64515575499014,0.949293639125307,0.31484417,"regulation of RNA export from nucleus"),
c("GO:0032386","regulation of intracellular transport",1.86512826257421,1.82884444389656,0.935940931259029,0.54667208,"regulation of RNA export from nucleus"),
c("GO:0046822","regulation of nucleocytoplasmic transport",0.604906463537583,1.90991585775686,0.936792918077596,0.6740036,"regulation of RNA export from nucleus"),
c("GO:0048679","regulation of axon regeneration",0.156827601657892,2.09813134676096,0.956400164757063,0.02909324,"regulation of axon regeneration"),
c("GO:0035020","regulation of Rac protein signal transduction",0.128822672790411,2.09256381891571,0.960002993315112,0.17713808,"regulation of axon regeneration"),
c("GO:0002431","Fc receptor mediated stimulatory signaling pathway",0.134423658563907,1.8573668261249,0.932754734410294,0.1777149,"regulation of axon regeneration"),
c("GO:0051493","regulation of cytoskeleton organization",3.00772936036742,1.54558103917188,0.960248179403188,0.35285491,"regulation of axon regeneration"),
c("GO:0051056","regulation of small GTPase mediated signal transduction",1.72510361823681,1.83256675914285,0.954884378114786,0.39667,"regulation of axon regeneration"),
c("GO:0038093","Fc receptor signaling pathway",0.280049288674807,1.81956329734495,0.937984579979689,0.63780086,"regulation of axon regeneration"),
c("GO:0032956","regulation of actin cytoskeleton organization",2.0331578357791,1.69185123615886,0.961619983566372,0.68044873,"regulation of axon regeneration"),
c("GO:0032970","regulation of actin filament-based process",2.25719726671894,1.60804470714603,0.971777971068089,0.03799712,"regulation of actin filament-based process"),
c("GO:0098586","cellular response to virus",0.487285762294164,1.93048196952178,0.98528395018499,0.07545864,"cellular response to virus"),
c("GO:0006914","autophagy",1.68589671782234,1.68499287063429,0.870998361919765,0.09689299,"autophagy"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# # by default, outputs to a PDF file

pdf( file="/Users/ulas/Projects/msc_thesis/figures/go_revigo_bio.pdf", width=16, height=9 ) # width and height are in inches
# check the tmPlot command documentation for all possible parameters - there are a lot more
treemap(
  stuff,
  index = c("representative","description"),
  vSize = "value",
  type = "categorical",
  vColor = "representative",
  title = "  ",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  bg.labels = "#CCCCCCAA",   # define background color of group labels
								 # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  fontsize.labels = 11,
  force.print.labels = TRUE,
  position.legend = "none"
)
dev.off()

