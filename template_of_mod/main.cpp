#include <mod/amlmod.h>
#include <mod/logger.h>
#include <mod/config.h>
#include <stdlib.h>

MYMOD(com.madleg.ragdoll, RagdollPhysics, 1.0, Madleg_JuniorDjjr)

Config* cfg = NULL;
int iNumSubsteps;
float fSimulationSpeed, fRagdollGravity;
bool bUseDynamicObjects;

extern "C" void OnModLoad() {
    logger->SetTag("RagdollPhysics");
    logger->Info("Ragdoll Mod Loading...");

    cfg = new Config("RagDoll_physics");
    iNumSubsteps = cfg->GetInt("CONFIG", "iNumSubsteps", 5);
    fSimulationSpeed = cfg->GetFloat("CONFIG", "fSimulationSpeed", 1.0f);
    fRagdollGravity = cfg->GetFloat("CONFIG", "fRagdollGravity", 1.0f);
    bUseDynamicObjects = cfg->GetBool("CONFIG", "bUseDynamicObjects", true);
    cfg->Save();

    char path[256];
    sprintf(path, "%s/RagDoll_physics.bin", aml->GetConfigPath()); 
    FILE* file = fopen(path, "rb");
    if (file) {
        fseek(file, 0, SEEK_END);
        long fileSize = ftell(file);
        fseek(file, 0, SEEK_SET);
        void* buffer = malloc(fileSize);
        if (buffer) {
            fread(buffer, fileSize, 1, file);
            logger->Info("RagDoll_physics.bin loaded!");
            free(buffer); 
        }
        fclose(file);
    }
    logger->Info("Ragdoll Mod initialization finished!");
}

