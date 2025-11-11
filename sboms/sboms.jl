using PkgToSoftwareBOM: spdxCreationData, generateSPDX, writespdx
using Pkg
using Test

Pkg.instantiate()
Pkg.precompile()

using MWETestSBOM_LazyArtifact: download_artifact, remove_artifact

function test_generate_sbom()
  # Generate SBOM
  try
    sbom = generateSPDX(spdxCreationData())
    spdxfile = joinpath(@__DIR__, "MWETestSBOM_LazyArtifact.spdx.json")
    writespdx(sbom, spdxfile)
    return true
  catch e
    return false
  end
end

# Make sure artifact is uninstalled
function test_without_artifact()
  remove_artifact("socrates")
  return test_generate_sbom()
end

function test_with_artifact()
  download_artifact("socrates")
  return test_generate_sbom()
end


@test test_with_artifact()

@test test_without_artifact()