module MWETestSBOM

using LazyArtifacts
using Pkg.Artifacts

export download_artifact
export remove_artifact

const ArtifactsList = Dict("socrates" => Base.SHA1("43563e7631a7eafae1f9f8d9d332e3de44ad7239"))

function download_artifact(name="socrates")
  @info "Downloading artifact: $name"
  @artifact_str name
end

function remove_artifact(name="socrates")
  path1 = artifact_path(ArtifactsList[name])
  if isdir(path1)
    @info "Removing artifact: $name"
    rm(path1; recursive=true, force=true)
  else
    @info "Artifact not found at $path1"
  end
  return nothing
end

end # module MWETestSBOM
