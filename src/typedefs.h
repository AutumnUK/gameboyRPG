#ifndef TYPEDEFS_H
#define TYPEDEFS_H 

typedef struct {   
    char        name[6];
    uint16_t    hp;
    uint16_t    max_hp;
    uint8_t     speed;
    uint8_t     attack;
    uint8_t     defence;
    uint16_t    xp;
} Enemy;

#endif