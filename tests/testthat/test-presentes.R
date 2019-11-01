context("Data sanity check")


test_that("data objects are unchanged", {

  expect_equal_to_reference(apodos, "apodos.rds")
  expect_equal_to_reference(centros_clandestinos_detencion, "centros_clandestinos_detencion.rds")
  expect_equal_to_reference(victimas_accionar_represivo_ilegal, "victimas_accionar_represivo_ilegal.rds")
  expect_equal_to_reference(victimas_accionar_represivo_ilegal_sin_denuncia_formal, "victimas_accionar_represivo_ilegal_sin_denuncia_formal.rds")
})
