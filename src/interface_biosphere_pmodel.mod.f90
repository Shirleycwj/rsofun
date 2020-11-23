module md_interface_pmodel

  use, intrinsic :: iso_fortran_env, dp=>real64

  use md_forcing_pmodel, only: climate_type, landuse_type, ninput_type, vegcover_type  
  ! use md_params_soil_pmodel, only: paramtype_soil
  use md_params_siml_pmodel, only: paramstype_siml, outtype_steering
  use md_params_core, only: nlayers_soil, ndayyear, npft
  use md_grid, only: gridtype !, domaininfo_type

  implicit none

  private
  public interfacetype_biosphere, outtype_biosphere, myinterface  

  type paramstype_calib
    ! real :: k_decay_tissue
    real :: kphio
    real :: soilm_par_a
    real :: soilm_par_b
    real :: vpdstress_par_a
    real :: vpdstress_par_b
    real :: vpdstress_par_m
  end type paramstype_calib  


  type interfacetype_biosphere
    integer                                        :: year
    real                                           :: pco2
    type(gridtype)                                 :: grid
    real, dimension(4,nlayers_soil)                :: soiltexture   ! soil texture (rows: sand, clay, organic, gravel; columns: layers from top)
    real                                           :: whc_prescr
    type(climate_type), dimension(:), allocatable  :: climate
    type(vegcover_type), dimension(:), allocatable :: vegcover
    ! type(domaininfo_type)                        :: domaininfo
    type(outtype_steering)                         :: steering
    type(paramstype_siml)                          :: params_siml
    real, dimension(npft)                          :: fpc_grid        ! allocatable because we don't know number of PFTs a priori
    type(paramstype_calib)                         :: params_calib    ! calibratable parameters
  end type interfacetype_biosphere

  type(interfacetype_biosphere) :: myinterface

  !----------------------------------------------------------------
  ! Return variable of biosphere()
  !----------------------------------------------------------------
  ! This is the derived type-return variable of the function biosphere(),
  ! holding variables used for the cost function in sofun_calib.f90
  type outtype_biosphere
    real :: gpp
    real :: fapar
    real :: transp
    real :: latenth
    real :: pet
    real :: vcmax
    real :: jmax
    real :: vcmax25
    real :: jmax25
    real :: gs_accl
  end type outtype_biosphere

end module md_interface_pmodel
