



# Objective 

- Investigate the effectiveness of CDR for prioritising partner services/contact tracing 
- Quantify the effectiveness of CDR-based allocation of partner services relative to other strategies


# Approach 

- Develop a network-based stochastic branching process model to describe the spread of HIV transmission clusters in MSM 
- Simulate HIV evolution and genetic distances in clusters 
- Identify how quickly clusters can be detected 
- Simulate variable rates of sampling, variable time to diagnosis, variable time to sequencing, and variable time to intervention
- Simultaneously consider alternative ways of prioritising patients for intervention: 
    - Random allocation amongst new diagnoses 
    - RITA based methods (prioritising recent infections)
    - Network-based interventions (prioritise new diagnoses with more self-reported recent partners) 


# Model 

## Population structure 

- Dynamic network model with three modes of contact: 
    - Long-term partnerships (mean duration 7 mo's) 
    - Casual partnerships (mean duration 2 mo's)
    - One-off contacts 
- Joint distribution of contact types calibrated to US MSM ARTNet survey data (Weiss et al, Epidemics 2020)

# Model 

## Dynamics 

- Continuous time stochastic branching process
- Simulation progresses using Gillespie exact simulation with competing rates for the following events: 
    - Changing partnerships
    - One-off contacts
    - Transmission 
    - Diagnosis 
    - Treatment
    - Sequencing 
    - Progression to AIDS and death 
- Transmissibility per contact follows viral loads resulting in time-dependent rate of transmission per partnership 
- Diagnosis & treatment further modify transmission rate 

# Model 

## Interventions 

- Intervention effectiveness is measured in terms of how quickly diagnosis is accerlated by partner services/contact tracing. 
- Developed a metric for the cumulative undiagnosed time averted (UTA) per patient 
- Cluster-based prioritisation studied with genetic distance thresholds from 0.5% to 2% and cluster size thresholds from 2-5 
    - Not currently considering cluster growth. Should we? 
- Network-based prioritisation uses a threshold self-reported cumulative partners over 7 months 
- Intervention is modelled with exponential (90 day) delays 
- Sequencing turnaround times are based on San Diego cohort data and are relatively short 

# Model 

## Calibration 

- All model parameters are based when possible on R Goyal et al's individual-based model: https://github.com/mathematica-pub/abm_hiv 
- Contact rates per partnership were calibrated to yeild stable incidence ($R_0=1$)


