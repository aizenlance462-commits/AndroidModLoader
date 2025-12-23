#include <mod/amlmod.h>
#include <mod/logger.h>
#include <mod/config.h>
#include <stdlib.h>

// 1. Setup Mod Info
MYMOD(com.madleg.ragdoll, RagdollPhysics, 1.0, Madleg_JuniorDjjr)

// 2. Global Variables
Config* cfg = NULL;
int iNumSubsteps;
float fSimulationSpeed, fRagdollGravity;
bool bUseDynamicObjects;

// 3. Main Function
extern "C" void OnModLoad() {
    logger->SetTag("RagdollPhysics");
    logger->Info("Ragdoll Mod Loading...");

    // Pagbasa ng Config
    cfg = new Config("RagDoll_physics");
    iNumSubsteps = cfg->GetInt("CONFIG", "iNumSubsteps", 5);
    fSimulationSpeed = cfg->GetFloat("CONFIG", "fSimulationSpeed", 1.0f);
    fRagdollGravity = cfg->GetFloat("CONFIG", "fRagdollGravity", 1.0f);
    bUseDynamicObjects = cfg->GetBool("CONFIG", "bUseDynamicObjects", true);
    cfg->Save();

    // Pagbasa ng .bin File (Physics Logic)
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
            logger->Info("RagDoll_physics.bin loaded successfully!");
            
            // NOTE: Dito gagamitin ang buffer para sa physics engine
            
            free(buffer); 
        }
        fclose(file);
    } else {
        logger->Error("RagDoll_physics.bin is missing in config folder!");
    }

    logger->Info("Ragdoll Mod initialization finished!");
} // <--- LINE 69: Dito dapat nagtatapos ang lahat.

