
This page contains R codes and data related to the article :

<b>[Repurposing of the multiciliation gene regulatory network in fate specification of Cajal-Retzius neurons](https://doi.org/10.1016/j.devcel.2023.05.011)</b>  
Matthieu X Moreau<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-2592-2373)</sup>, Yoann Saillour<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-5110-9239)</sup>, Vicente Elorriaga<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-4899-1782)</sup>, Benoît Bouloudi, Elodie Delberghe, Tanya Deutsch Guerrero, Amaia Ochandorena-Saa<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-2431-0535)</sup>, Laura Maeso-Alonso<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0001-7805-3792)</sup>, Margarita M Marques<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-2818-035X)</sup>, Maria C Marin<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-7149-287X)</sup>, Nathalie Spassky<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-7149-287X)</sup>, Alessandra Pierani<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-4872-4791)</sup> & Frédéric Causeret<sup>[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-0543-4938)</sup>  
<i>[Developmental Cell](https://doi.org/10.1016/j.devcel.2023.05.011)</i> 2023 Aug 7; 58(15):1365-1382.e6.

For a user-friendly browsing of the data, consider our <b>[Shiny App](https://apps.institutimagine.org/mouse_hem/)</b>

## Links to raw data and metadata
- Raw count matrix are deposited in GEO (Accession number [GSE220237](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE220237))  
- Barcodes, coordinates and metadata of QC-filtered cells can be retreived [here](https://github.com/fcauseret/hemCR/tree/main/Metadata)  

## R codes
[Cell quality control (using Seurat v2)](./Quality-Control/Quality_Control.html)  
[Conversion to Seurat v4, normalization and broad clustering](./Quality-Control/Seurat_ConversionV4.html)  
[Progenitors diversity](./ProgenitorsDiversity/ProgenitorDiversity.html)  
[Cell cycle analysis](./ProgenitorsDiversity/Cellcycle_analysis.html)  
[Cell cycle variable genes](./ProgenitorsDiversity/Cycling_Behaviours.html)  
[Cajal-Retzius trajectory](./CajalRetzius_trajectory/Cajal-Retzius_Trajectory.html)  
[Choroid plexus trajectory](./ChoroidPlexus_trajectory/ChoroidPlexus.html)  
[QC Gmnc KO](./Gmnc_KO/Quality-control.html)  
[WT annotation](./WT_KO_integration/WT_annotation.html)  
[WT/KO integration](./Gmnc_KO/Seurat_integration.html)  
[CR trajectory in Gmnc KO](./Gmnc_KO/KO_Trajectories.html)  
[Comparison of CR trajectories between WT and KO](./Gmnc_KO/WT-KO_Trajectories_comparision.html)  
[Comparison of ChP trajectories between WT and KO](./Gmnc_KO/WT-KO_CPx_Trajectories.html)  
 



